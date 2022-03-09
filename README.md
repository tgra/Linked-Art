# Linked Art - Transformation Exemplar

- [Webpage view of this content](https://tgra.github.io/Linked-Art/)
- [GitHub Repo view of this content](https://github.com/tgra/Linked-Art/blob/main/README.md)

## Introduction
[Linked Art](https://linked.art) is a community working together to create a shared Model based on Linked Open Data to describe Art.

A number of exemplars will be published to demonstrate the processes involved in producing Linked Art JSON-LD, and also the potential applications of Linked Art, on the theme of:
- `Transformation` - Documented transformation process - using code, documentation and possibly visualisation
- `Reconciliation` - Documented reconciliation process - matching data with an external identifier source
- `Visualisation` - Documented transformation of Linked Art JSON-LD to data visualisation

![Linked Art exemplars](https://github.com/tgra/linked-art/blob/main/docs/media/img/exemplar.png?raw=true)

This exemplar is concerned with `Transformation` - the transformation process, from collections data to Linked Art JSON-LD.

---
## Transformation Exemplar - From Collections Data to Linked Art JSON-LD

This repository contains a worked example of the transformation process for Linked Art, transforming collections data into Linked Art JSON-LD.

## Aim
The aim is to demonstrate how easy it is to transform collections data to Linked Art JSON-LD.

## How
The `Transformation` exemplar is in the form of collection of interactive documented code, as [Jupyter notebooks](https://jupyter.org).

---
## How to view Jupyter Notebooks
The following options are available to view the Jupyter notebooks. Installation of Anaconda with a local download of the Jupyter Notebooks is recommended to provide the interactive, documented code features of the notebooks.

### Anaconda
>[Anaconda](https://www.anaconda.com) is a data science workbench that can be installed locally, that included Jupyter Notebook. To view all features of the notebook, it's recommended that you use Anaconda. Anaconda is [available to download](https://www.anaconda.com/products/individual). 

### Binder 
>Binder is an online services that allows interactive Jupyter Notebooks to be viewed online. The following link will allows you to view the Jupyter Notebooks in this repository using Binder. [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD)

## nbviewer
[nbviewer](https://nbviewer.org/)
> nbviewer is an online service that will render a static view of a Jupyter notebook using a URL.

### GitHub 
> Github offers a static view of a Jupyter Notebook. Viewing the file in GitHub is simply a matter of selecting the relevant *.iynb file in the `jupyter_notebooks` folder

---
## Documented Interactive Code Jupyter Notebooks
The different types of Jupyter notebooks:
- Transform - transformations using real-world collections data
- Reconcile - reconciliation of collections data with authoritative data on geographical place names
- Visualise - visualisation using Linked Art JSON-LD
  

|Notebook type | Notebook  | Download | nbviewer | Binder |
| -------- | ------------- | ------------- | ------- | ------ |
| Transform | Indianapolis Museum of Art  |  [download](01-01-Transform-XML-IMA.ipynb) | [nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/01-01-Transform-XML-IMA.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=01-01-Transform-XML-IMA.ipynb)|
| Transform| Philadelphia Museum of Art | [download](01-04-Transform-CSV-PMA.ipynb) | [nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/01-04-Transform-CSV-PMA.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=01-04-Transform-CSV-PMA.ipynb) |
| Transform| Cleveland Museum of Art | [download](01-02-Transform-CSV-CMA.ipynb) | [nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/01-02-Transform-CSV-CMA.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=01-02-Transform-CSV-CMA.ipynb) |
| Transform| Cleveland Museum of Art - simplified | [download](01-10-Transform-CSV-CMA-Simplified.ipynb) | [nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/01-10-Transform-CSV-CMA-Simplified.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=01-10-Transform-CSV-CMA-Simplified.ipynb) |
| Transform| National Gallery of Art | [download](01-03-Transform-CSV-NGA.ipynb) | [nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/01-03-Transform-CSV-NGA.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=01-03-Transform-CSV-NGA.ipynb) |
| Transform| Harvard Art Museum | [download](01-05-Transform-JSON-Harvard-API.ipynb) | [nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/01-05-Transform-JSON-Harvard-API.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=01-05-Transform-JSON-Harvard-API.ipynb) |


| Transform | John Ruskin artworks - Timeline - Transform Data | [download](01-06-Transform-John-Ruskin.ipynb)|[nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/01-06-Transform-John-Ruskin.ipynb)|[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=01-06-Transform-John-Ruskin.ipynb)|
| Reconcile| John Ruskin artworks - reconcile place names | [download](02-01-Reconcile-John-Ruskin-Place-Names.ipynb) | [nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/02-01-Reconcile-John-Ruskin-Place-Names.ipynb) | [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=02-01-Reconcile-John-Ruskin-Place-Names.ipynb) |
| Visualise | John Ruskin artworks - Timeline - Visualise with Google | [download](03-02-Visualise-John-Ruskin-Timeline-Google-Spreadsheet.ipynb)|[nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/03-02-Visualise-John-Ruskin-Timeline-Google-Spreadsheet.ipynb)|[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=03-02-Visualise-John-Ruskin-Timeline-Google-Spreadsheet.ipynb)|
| Visualise | John Ruskin artworks - Timeline - Visualise locally | [download](03-03-Visualise-John-Ruskin-Timeline-Local-File.ipynb)|[nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/03-03-Visualise-John-Ruskin-Timeline-Local-File.ipynb)|[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=03-03-Visualise-John-Ruskin-Timeline-Local-File.ipynb)|
| Visualise | John Ruskin artworks - StoryMap | [download](03-04-Visualise-John-Ruskin-Story-Map.ipynb)|[nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/main/03-04-Visualise-John-Ruskin-Story-Map.ipynb)|[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/HEAD?labpath=03-04-Visualise-John-Ruskin-Story-Map.ipynb)|



## Availability

All of the Jupyter notebooks can be downloaded as a [zip file](https://github.com/tgra/Linked-Art/archive/refs/heads/main.zip) or checked out of the Github repository:
- [https](https://github.com/tgra/Linked-Art.git)
- GitHub client `gh repo clone tgra/Linked-Art`

Alternatively, they can be [viewed directly on GitHub](https://github.com/tgra/Linked-Art/tree/main/jupyter_notebooks). 

## Community Feedback

We welcome feedback on the notebooks provided here for the `Transformation` exemplar. If you have a moment, please consider the following questions and send your comments to Tanya Gray at tanya.gray@humanities.ox.ac.uk. Thank you.


> Thinking about your colleagues who are less familiar with Linked Art, can we do anything with this tool to make it more useful? 

> Does the tool make sense?

> Are the workbook steps too large or too small? 
Are the steps of the correct granularity?

## Transformation of Other Collections Data 
This workbook works with EMu export data in XML - can you offer data in this format to transform?

We would also welcome collections data from other collections in other formats to transform to Linked Art JSON-LD.

Please contact Tanya Gray at tanya.gray@humanities.ox.ac.uk to discuss.

## What's next?  

Further exemplars for Linked Art will be published on the themes of `Reconciliation` and `Visualisation`

## Acknowledgements

This work was undertaken by the [Linked Art II project](https://linked.art/community/projects/linkedartii/) at the University of Oxford 
(Principal Investigator: Dr. Kevin Page, Oxford e-Research Centre) funded by the UK Arts and Humanities Research Council (AHRC project reference AH/T013117/1). The project's Research Software Engineer was Tanya Gray. We gratefully acknowledge the participation and contributions of our project partners and the wider Linked Art community.

