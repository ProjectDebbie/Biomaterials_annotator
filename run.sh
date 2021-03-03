#!/bin/bash
#set pipeline name
pipeline_name=biomaterials_pipeline_`date '+%d-%m-%Y_%H_%M_%S'`
#set the nextflow instalation
nextflow_path="/home/jcorvi/nextflow_installation/nextflow"
#set the pipeline file
pipeline_path="/home/jcorvi/projects/debbie/Biomaterials_annotator/pipeline.nf"
#set the pubmed abstracts home folder
input_folder="/home/jcorvi/ ddd"
#set the home/work dir of the pipeline
base_dir="/home/jcorvi/DEBBIE_DATA/pipel"`date '+%d-%m-%Y'`

#command
$nextflow_path run $pipeline_path --inputDir $pubmed_base_dir --baseDir $base_dir -with-report $base_dir/report.html -with-trace -with-timeline $base_dir/timeline.html -name $pipeline_name
