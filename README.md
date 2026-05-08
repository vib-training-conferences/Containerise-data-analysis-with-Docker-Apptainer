<!--

author:   Alexander Botzki, Bruna Piereck
email:    training@vib.de
version:  1.0.0
language: en
narrator: UK English Female

icon:     https://vib.be/sites/vib.sites.vib.be/files/logo_VIB_noTagline.svg

comment:  This document shall provide an entire compendium and course on the
          development of Open-courSes with [LiaScript](https://LiaScript.github.io).
          As the language and the systems grows, also this document will be updated.
          Feel free to fork or copy it, translations are very welcome...

script:   https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.js
          https://felixhao28.github.io/JSCPP/dist/JSCPP.es5.min.js

link:     https://cdn.jsdelivr.net/chartist.js/latest/chartist.min.css
link:     https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css
link:     https://raw.githubusercontent.com/vibbits/material-liascript/master/img/org.css
link:     https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css
link:     https://fonts.googleapis.com/css2?family=Saira+Condensed:wght@300&display=swap
link:     https://fonts.googleapis.com/css2?family=Open+Sans&display=swap
link:     https://raw.githubusercontent.com/vibbits/material-liascript/master/vib-styles.css

@JSONLD
<script run-once>
  let json = @0 

  const script = document.createElement('script');
  script.type = 'application/ld+json';
  script.text = JSON.stringify(json);

  document.head.appendChild(script);

  // this is only needed to prevent and output,
  // as long as the result of a script is undefined,
  // it is not shown or rendered within LiaScript
  console.debug("added json to head")
</script>
@end

orcid:    [@0](@1)<!--class="orcid-logo-for-author-list"-->

tutor:    Introduction to Docker and Singularity
edition:  5th 

-->

# Introduction to Containers workshop

<section>

Hello and welcome to our @tutor workshop! We are very happy to have you here.

This is the @edition edition of this workshop, jointly organised by VIB and ELIXIR.

> We are using the interactive Open Educational Resource online/offline course infrastructure called LiaScript.
> It is a distributed way of creating and sharing educational content hosted on github.
> To see this document as an interactive LiaScript rendered version, click on the
> following link/badge: [LiaScript](https://liascript.github.io/course/?https://raw.githubusercontent.com/vib-tcp/containers-workshop/main/README.md)

## General context

This repository contains the materials (exercises) for the workshop on containers of May 20, 2021. We will focus on Docker and Singularity.
Subsequent editions have taken place in January and October 2022 and March 2023, October 2023 and February 2024.

Some exercises are inspired upon the examples from [Microsoft Azure ML github repo](https://github.com/Azure/azureml-examples). The content of this repo is licensed with MIT license.

Other exercises are co-created with the [Code Reproducibility team of the ELIXIR network](https://github.com/elixir-europe-training/CodeReproducibility)

The **presentations** which goes alongside this material can be found [in the Lesson overview: Slides](./presentations/docker_apptainer_workshop_20241015_v0.2.pdf) .

## Proposed Schedule

Schedule day 1:

- 9:30 - 11:00 - session Introduction to Docker
- 11:00 - 11:15 - break
- 11:15 - 12:45 - session Docker 
   - Registries
   - Running
- 12:45 - 13:45 - lunch
- 13:45 - 15:15 - session Docker 
   - Mounts
   - Ports
- 15:15 - 15:30 - break
- 15:30 - 17:00 - session Docker recipes
   - Building

Schedule day 2:

- 9:30 - 11:00 - recap day 1 
   - Bring the pieces together - exercise 5
- 11:00 - 11:15 - break
- 11:15 - 12:45 - session Introduction to Singularity
- 12:45 - 13:45 - lunch
- 13:45 - 15:15 - session Singularity on the HPC
- 15:15 - 15:30 - break
- 15:30 - 17:00 - session Singilarity recipes

</section>

```json   @JSONLD
{
  "@context": "https://schema.org/",
  "@type": "LearningResource",
  "@id": "https://elixir-europe-training.github.io/ELIXIR-TrP-TeSS/",
  "http://purl.org/dc/terms/conformsTo": {
    "@type": "CreativeWork",
    "@id": "https://bioschemas.org/profiles/TrainingMaterial/1.0-RELEASE"
  },
  "description": "Introduction to Docker and Apptainer",
  "keywords": "Docker, Containers, Recipes, Singularity",
  "name": "Introduction to Docker and Apptainer",
  "license": "https://creativecommons.org/licenses/by/4.0/",
  "educationalLevel": "beginner",
  "competencyRequired": "none",
  "teaches": [
    "Define what containers are and articulate the differences between Docker and Singularity.",
   "Identify the components of a Docker recipe and correlate with the layers within a Docker image.",
   "List the benefits of containerization, considering reproducibility, usage and installation.",
   "Recognize the use cases where Docker is the preferred method for deploying applications.",
    "Discuss case studies to justify the selection of Docker or Singularity for specific deployment scenarios."
  ],
  "audience": "researchers",
  "inLanguage": "en-US",
  "learningResourceType": [
    "tutorial"
  ],
  "author": [
    {
      "@type": "Person",
      "name": "Bruna Piereck"
    },
    {
      "@type": "Person",
      "name": "Alexander Botzki"
    }
  ],
  "contributor": [
    {
      "@type": "Person",
      "name": "Christof De Bo"
    }
  ]
}
```



# Lesson overview

> <i class="fa fa-lock"></i> **License:** [Creative Commons Attribution 4.0 International  License](https://creativecommons.org/licenses/by/4.0/deed.en)
>
> <i class="fa fa-user"></i> **Target Audience:** Researchers
>
> <svg xmlns="http://www.w3.org/2000/svg" height="14" width="16" viewBox="0 0 576 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2023 Fonticons, Inc.--><path d="M384 64c0-17.7 14.3-32 32-32H544c17.7 0 32 14.3 32 32s-14.3 32-32 32H448v96c0 17.7-14.3 32-32 32H320v96c0 17.7-14.3 32-32 32H192v96c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32s14.3-32 32-32h96V320c0-17.7 14.3-32 32-32h96V192c0-17.7 14.3-32 32-32h96V64z"/></svg> **Level:** Beginner  
>
> <i class="fa fa-arrow-left"></i> **Prerequisites**  
> To be able to follow this course, learners should have knowledge in:
> 
> 1. Knowledge of Command line Interface is a plus  
>
> <i class="fa fa-bookmark"></i> **Description** The course will give an introduction to containers (Docker & Apptainer) which are great components to achieve portability and reproducibility of your analysis. You will learn how to use containers and how to build a container from scratch, share it with others and how to re-use and modify existing containers. After an extensive explanation on Docker containers, the Apptainer application, previously Singularity, and its use in the HPC will be highlighted as well. 
> 
> <i class="fa fa-arrow-right"></i> **Learning Outcomes:**  
> By the end of the course, learners will be able to:
>
> 1. Define what containers are and articulate the differences between Docker and Singularity. [Knowledge]
> 2. Discuss case studies to justify the selection of Docker or Singularity for specific deployment scenarios. [Knowledge]
> 3. Assess the ease-of-use and user-friendliness of Docker and Singularity for deploying complex applications. [Knowledge and Comprehension]
> 4. Identify the components of a Docker recipe and correlate with the layers within a Docker image. [Knowledge and Comprehension]
> 5. List the benefits of containerization, considering reproducibility, usage and installation. [Knowledge]
> 6. Recognize the use cases where Docker is the preferred method for deploying applications. [Knowledge]
> 7. Analyze the components of a Docker recipe and their impact on container performance and storage. [Comprehension]
> 8. Summarize the process of writing a Docker recipe, building Docker images, and running containers. [Synthesis]
> 9. Explain the importance of Docker caching and working with I/O volumes in containerized environments. [Comprehension]
> 10. Compare advantages and disadvantages of Docker and Singularity for specific use cases, including distribution methods and safety. [Knowledge and Comprehension]
> 11. Apply Docker commands and utilize Docker containers to deploy web applications and analysis tools [Apply]
> 12. Develop Docker recipes and Singularity images tailored to the needs of different analysis pipelines. [Apply]
> 13. Creating Singularity images based on Docker recipes for running in an HPC environment [Apply]
>
>> Check more about [Bloom's taxonomy](https://cft.vanderbilt.edu/guides-sub-pages/blooms-taxonomy/) to categorize the levels in educational goals
>
> <i class="fa fa-hourglass"></i> **Time estimation**: 480 minutes
>
> <i class="fa fa-asterisk"></i> **Requirements:** The (technical) installation requirements are described in the Chapters overview section Getting ready.
>
> <i class="fa fa-envelope-open-text"></i> **Supporting Materials**:
> 
> 1. [Exercises and solutions](https://github.com/vibbits/containers-workshop/tree/main/exercises)
> 2. [Slides day 1+2](https://github.com/vibbits/containers-workshop/blob/main/presentations/docker_apptainer_workshop_20241015_v0.2.pdf)  
> 
> <i class="fa fa-life-ring"></i> **Acknowledgement**:
>
> * [ELIXIR Belgium](https://www.elixir-belgium.org/)
> * [VIB Technologies](https://www.vib.be/)
>
> <i class="fa fa-money-bill"></i> **Funding:** This project has received funding from VIB.
>
> <i class="fa fa-anchor"></i> **PURL**:  https://zenodo.org/badge/DOI/10.5281/zenodo.14231766.svg


# Authors and Contributors

Authors

- [Bruna Piereck](@[orcid](https://orcid.org/0000-0001-5958-0669)
- [Alexander Botzki](@[orcid](https://orcid.org/0000-0001-6691-4233)
- [Tuur Muyldermans]([orcid](https://orcid.org/0000-0002-3926-7293)

Contributors

- we welcome contributors for these materials

## Citing this lesson

Please cite as:

  1. to be added once we have released the first DOI

# References

Here are some great tips for learning and to get inspired for your own use:

* [slides by Melbourne Bioinformatics.org](https://www.melbournebioinformatics.org.au/tutorials/tutorials/docker/media/#1)
* [Introduction by BioCore CRG](https://github.com/biocorecrg/ELIXIR_containers_nextflow)

# About us

*About ELIXIR Training Platform*

The ELIXIR Training Platform was established to develop a training community that spans all ELIXIR member states (see the list of Training Coordinators). It aims to strengthen national training programmes, grow bioinformatics training capacity and competence across Europe, and empower researchers to use ELIXIR's services and tools.

One service offered by the Training Platform is TeSS, the training registry for the ELIXIR community. Together with ELIXIR France and ELIXIR Slovenia, VIB as lead node for ELIXIR Belgium is engaged in consolidating quality and impact of the TeSS training resources (2022-23) (https://elixir-europe.org/internal-projects/commissioned-services/2022-trp3).

The Training eSupport System was developed to help trainees, trainers and their institutions to have a one-stop shop where they can share and find information about training and events, including training material. This way we can create a catalogue that can be shared within the community. How it works is what we are going to find out in this course.

*About VIB and VIB Technologies*

VIB is an entrepreneurial non-profit research institute, with a clear focus on groundbreaking strategic basic research in life sciences and operates in close partnership with the five universities in Flanders – Ghent University, KU Leuven, University of Antwerp, Vrije Universiteit Brussel and Hasselt University.

As part of the VIB Technologies, the 12 VIB Core Facilities, provide support in a wide array of research fields and housing specialized scientific equipment for each discipline. Science and technology go hand in hand. New technologies advance science and often accelerate breakthroughs in scientific research. VIB has a visionary approach to science and technology, founded on its ability to identify and foster new innovations in life sciences.

The goal of VIB Technology Training is to up-skill life scientists to excel in the domains of VIB Technologies, Bioinformatics & AI, Software Development, and Research Data Management.

--------------------------------------------

*Editorial team for this course*

Authors: @[orcid(Alexander Botzki)](https://orcid.org/0000-0001-6691-4233), @[orcid(Bruna Piereck)](https://orcid.org/0000-0001-5958-0669)

Technical Editors: Alexander Botzki
