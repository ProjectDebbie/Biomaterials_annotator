# Biomaterials annotator
The Biomaterials Annotator: a system for ontology-based concept annotation of biomaterials text.

The Biomaterials Annotator is an ontology-based NER system that identifies biomaterial specific types of concepts. It provides a schema for combining terms from mutiple ontologies and nomenclutures that are listed below.  

The Biomaterials Annotator has been implemented following a modular organization using software containers for the different components and orchestrated  using  Nextflow  as  workflow  manager. Natural language processing (NLP) components  are  mainly  developed  in  Java.


# Biomaterials Annotated Gold Standard Corpus 
An annotated biomaterial gold standard corpus of 1222 MEDLINE abstract, resulting from the execution of the Biomaterials Annotator is available and free ...
Each abstract is individually contained as a separate file under the GATE format.
## System architecture
![](Annotator_structure.png)

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

## Actual Version: 1.0, 2021-03-03
## [Changelog](https://github.com/ProjectDebbie/Biomaterials_annotator/blob/master/CHANGELOG)


## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/ProjectDebbie/Biomaterials_annotator/tags).

## Authors

**Javi Corvi and Osnat Hakimi**

## To cite the Biomaterials Annotator
Add publication

## License

This project is licensed under the GNU License - see the [LICENSE](LICENSE) file for details

## Funding

<img align="left" width="75" height="50" src="eu_emblem.png"> This project has received funding from the European Union’s Horizon 2020 research and innovation programme under the Marie Sklodowska-Curie grant agreement No 751277
