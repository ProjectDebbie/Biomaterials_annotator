# Biomaterials annotator
The Biomaterials Annotator: a system for ontology-based concept annotation of biomaterials text.

The Biomaterials Annotator is an ontology-based NER system that identifies biomaterial concepts. It provides a schema for combining terms from mutiple ontologies, vocabularies and nomenclutures. A full list of the type of concepts annotated are available [here](Data_model.csv). 

The global scores calculated for the system are:  0.75 strict F-score, 0.79 lenient F-Score and 0.77 average F-score. The full results including metrics by category are available [here](Biomaterials_Annotator_Performance.csv).

The Biomaterials Annotator has been implemented following a modular organization, using software containers for the different components. The pipeline is orchestrated using  Nextflow  as  workflow  manager. Natural language processing (NLP) components  were  mainly  developed  in Java, and it relying on the Stanford CoreNLP Natural Language Processing open source toolkit. 

## Annotated corpus
A biomaterials annotated gold standard corpus of 1222 MEDLINE abstracts resulting from the execution of the Biomaterials Annotator is available and free to use at https://github.com/ProjectDebbie/Biomaterials_annotated_corpus. The corpus contains articles describing the evaluation of biomaterials and medical devices in either a laboratory or clinical setting, 
Each abstract is individually contained as a separate file under the GATE format.

## Biomaterials Annotator Project Overview
![](Overview_Biomaterials_Annotator.png)

## System architecture
![](Annotator_structure.png)

The Standard NLP preprocessing component is available at https://gitlab.bsc.es/inb/text-mining/generic-tools/nlp-standard-preprocessing
The MSH Annotator annotates pre-selected categories from the MeSH terminology; and the Dictionary Annotator annotates does the same using manually collected ontologies and vocabularies. This is followed by execution of the Post-processing rules, including entity recognition based on lexical rules, removal of false positives and abbreviations concept recognition, among other tasks. 

The MSH Annotator is available at https://github.com/ProjectDebbie/debbie_umls_annotations; and the Dictionary Annotator and Post-processing rules are available at https://github.com/ProjectDebbie/DEBBIE_dictionaries_annotations. 

## Ontologies used for the annotations
1. [MESH (UMLS)](https://bioportal.bioontology.org/ontologies/MESH)
2. [DEB](https://bioportal.bioontology.org/ontologies/DEB)
3. [GMDN](https://www.gmdnagency.org/)
4. [CHEBI](https://bioportal.bioontology.org/ontologies/CHEBI)
5. [IOBC](https://bioportal.bioontology.org/ontologies/IOBC)
6. [NCIT](https://bioportal.bioontology.org/ontologies/NCIT)
7. [NPO](https://bioportal.bioontology.org/ontologies/NPO)
8. [OBI](https://bioportal.bioontology.org/ontologies/OBI)
9. [ONTOTOXNUC](https://bioportal.bioontology.org/ontologies/ONTOTOXNUC)
10. [UBERON](https://bioportal.bioontology.org/ontologies/UBERON)
11. [PREMEDONTO](https://bioportal.bioontology.org/ontologies/PREMEDONTO)
12. [EDAM Bioimaging Ontology](https://bioportal.bioontology.org/ontologies/EDAM-BIOIMAGING)
13. [CHMO](https://bioportal.bioontology.org/ontologies/CHMO)




## Run the Biomaterials Annotator 

You need to have docker and nextflow installed, then configure and the run.sh file.

## Actual Version: 1.0, 2021-03-23
## [Changelog](https://github.com/ProjectDebbie/Biomaterials_annotator/blob/master/CHANGELOG)


## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/ProjectDebbie/Biomaterials_annotator/tags).

## Authors

**Javier Corvi and Osnat Hakimi**

## To cite the Biomaterials Annotator
Corvi, J., Fuentesl ́opez, C., Fern ́andez, J., Gelpi, J., Ginebra, M.-P.,Capella-Guitierrez, S., Hakimi, O.: The biomaterials annotator: a systemfor ontology-based concept annotation of biomaterials text. In:Proceedings of the Second Workshop on Scholarly DocumentProcessing, pp. 36–48. Association for Computational Linguistics,Online (2021). https://www.aclweb.org/anthology/2021.sdp-1.5

[BibText](BibTextBiomaterialAnnotator.bib)

## License

This project is licensed under the GNU License - see the [LICENSE](LICENSE) file for details

## Funding

<img align="left" width="75" height="50" src="eu_emblem.png"> This project has received funding from the European Union’s Horizon 2020 research and innovation programme under the Marie Sklodowska-Curie grant agreement No 751277
