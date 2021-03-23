#!/usr/bin/env nextflow

pipeline_version = 1.0

log.info """
This is the Biomaterials Annotator pipeline.
The input directory is: ${params.inputDir}, Contains the files to be processed.
Base directory to use: ${params.baseDir}, This directory is used together with the pipeline name (-name parameter) output the results.
The output will be located at ${params.baseDir}.
Pipeline execution name: ${workflow.runName}
Pipeline version: ${pipeline_version}
"""
.stripIndent()

//Configuration of the original pdf directory

params.general = [
    paramsout:          "${params.baseDir}/execution-results/params_${workflow.runName}.json",
    resultout:          "${params.baseDir}/execution-results/results_${workflow.runName}.txt",
    baseDir:            "${params.baseDir}",
    inputDir:           "${params.inputDir}"
]

log.info """
The text-mining execution results will be stored in output folder.
"""
.stripIndent()

steps = [:]

pipeline_log = "${params.baseDir}/pipeline_from_classifier.log"


params.folders = [
    //Output directory for the nlp-standard preprocessing step
	nlp_standard_preprocessing_output_folder: "${params.baseDir}/nlp_standard_preprocessing_output",
	//Output directory for the umls tagger step
	umls_output_folder: "${params.baseDir}/umls_output",
	//Output directory for the umls tagger step
	debbie_dictionaries_output_folder: "${params.baseDir}/debbie_dictionaries_output"
]

abstract_input_ch = Channel.fromPath( params.inputDir, type: 'dir' )

nlp_standard_preprocessing_output_folder=file(params.folders.nlp_standard_preprocessing_output_folder)
umls_output_folder=file(params.folders.umls_output_folder)
debbie_dictionaries_output_folder=file(params.folders.debbie_dictionaries_output_folder)

abstract_input_folder = params.general.inputDir

void printSection(section, level = 1){
    println (("  " * level) + "↳ " + section.key)
    if (section.value.class == null)
    {
      for (element in section.value)
        {
           printSection(element, level + 1)
        }
    }
    else {
        if (section.value == "")
            println (("  " * (level + 1) ) + "↳ Empty String")
        else
            println (("  " * (level + 1) ) + "↳ " + section.value)
    }
}

void PrintConfiguration(){
    println ""
    println "=" * 34
    println "DEBBIE text-mining pipeline Configuration"
    println "=" * 34
    for (configSection in params) {
          //println (configSection.getClass())     
          if(configSection.key=="general" || configSection.key=="database" || configSection.key=="folders"){

            printSection(configSection)
            println "=" * 30
          }
       
    }

    println "\n"
}

String parseElement(element){
    if (element instanceof String || element instanceof GString ) 
        return "\"" + element + "\""    

    if (element instanceof Integer)
        return element.toString()

    if (element.value.class == null)
    {
        StringBuilder toReturn = new StringBuilder()
        toReturn.append()
        toReturn.append("\"")
        toReturn.append(element.key)
        toReturn.append("\": {")

        for (child in element.value)
        {
            toReturn.append(parseElement(child))
            toReturn.append(',')
        }
        toReturn.delete(toReturn.size() - 1, toReturn.size() )
        
        toReturn.append('}')
        return toReturn.toString()
    } 
    else 
    {
        if (element.value instanceof String || element.value instanceof GString ) 
            return "\"" + element.key + "\": \"" + element.value +debbie_dictionaries_output_folder+"\""            

        else if (element.value instanceof ArrayList)
        {
            // println "\tis a list"
            StringBuilder toReturn = new StringBuilder()
            toReturn.append("\"")
            toReturn.append(element.key)
            toReturn.append("\": [")
            for (child in element.value)
            {gate_to_json
                toReturn.append(parseElement(child)) 
                toReturn.append(",")                
            }
            toReturn.delete(toReturn.size() - 1, toReturn.size() )
            toReturn.append("]")
            return toReturn.toString()
        }

        return "\"" + element.key + "\": " + element.value
    }
}

def SaveParamsToFile() {
    // Check if we want to produce the params-file for this execution
    if (params.paramsout == "")
        return;

    // Replace the strings ${baseDir} and ${workflow.runName} with their values
    //params.general.paramsout = params.general.paramsout
    //    .replace("\${baseDir}".toString(), baseDir.toString())
    //    .replace("\${workflow.runName}".toString(), workflow.runName.toString())

    // Store the provided paramsout value in usedparamsout
    params.general.usedparamsout = params.general.paramsout

    // Compare if provided paramsout is the default value
    if ( params.general.paramsout == "${baseDir}/param-files/${workflow.runName}.json"){
        // And store the default value in paramsout
        params.general.paramsout = "\${baseDir}/param-files/\${workflow.runName}.json"
    }

    // Inform the user we are going to store the params-file and how to use it.
    println "[Config Wrapper] Saving current parameters to " + params.general.usedparamsout + "\n" +
            "                 This file can be used to input parameters providing \n" + 
            "                   '-params-file \"" + params.general.usedparamsout + "\"'\n" + 
            "                   to nextflow when running the workflow."


    // Manual JSONification of the params, to avoid using libraries.
    StringBuilder content = new StringBuilder();
    // Start the dictionary
    content.append("{")

    // As parseElement only accepts key-values or dictionaries,
    //      we iterate here for each 'big-category'
    for (element in params) 
    {
        // We parse the element
        content.append(parseElement(element))
        // And add a comma to separate elements of the list
        content.append(",")
    }

    // Remove the last comma
    content.delete(content.size() - 1, content.size() )
    // And add the final bracket
    content.append("}")

    // Create a file handler for the current usedparamsout
    configJSON = file(params.general.usedparamsout)
    // Make all the dirs of usedparamsout path
    configJSON.getParent().mkdirs()
    // Write the contents to file
    configJSON.write(content.toString())
}


//Execution Begin
PrintConfiguration()
SaveParamsToFile()

//Workflow component Begins

process nlp_standard_preprocessing {
    input:
    file input_nlp_standard_preprocessing from abstract_input_ch

    output:
    val nlp_standard_preprocessing_output_folder into nlp_standard_preprocessing_output_folder_ch

    script:
    """
    exec >> $pipeline_log
    echo "********************************************************************************************************************** "
    echo `date`
    echo "Start Pipeline Execution, Pipeline Version $pipeline_version, workflow name: ${workflow.runName} "
    echo "Start nlp_standard_preprocessing"
    nlp-standard-preprocessing -i $input_nlp_standard_preprocessing -o $nlp_standard_preprocessing_output_folder -a BSC -t 8
    echo "End nlp_standard_preprocessing"
    """
}

process debbie_umls_annotation {
    input:
    file input_umls from nlp_standard_preprocessing_output_folder_ch

    output:
    val umls_output_folder into umls_output_folder_ch

    """
    exec >> $pipeline_log
    echo "Start biomaterial_umls_msh_annotation"
    debbie-umls-annotator -i $input_umls -o $umls_output_folder -a BSC -gt flexible -t 1
    echo "End biomaterial_umls_msh_annotation"
    """
}

process debbie_dictionary_annotation {
    input:
    file input_debbie_dictionaries from umls_output_folder_ch
    output:
    val debbie_dictionaries_output_folder into debbie_dictionaries_output_folder_ch

    """
    exec >> $pipeline_log
    echo "Start biomaterial_dictionary_annotation"
    biomaterials-annotator -i $input_debbie_dictionaries -o $debbie_dictionaries_output_folder -a BSC -gt flexible -t 1
    echo "End biomaterial_dictionary_annotation"
    """
}

workflow.onComplete {
        println ("Workflow Done !!! ")
        """
        exec >> $pipeline_log
        echo "End Pipeline Execution, Pipeline Version $pipeline_version, workflow name ${workflow.runName}"
        echo "********************************************************************************************************************** "
        """
}
