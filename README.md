# Linked Art - Transformation Exemplar

## Introduction
[Linked Art](https://linked.art) is a community working together to create a shared Model based on Linked Open Data to describe Art.

A number of exemplars will be published to demonstrate the processes involved in producing Linked Art JSON-LD, and also the potential applications of Linked Art, on the theme of:
- `Transformation` - Documented transformation process - using code, documentation and possibly visualisation
- `Reconciliation` - Documented reconciliation process - matching data with an external identifier source
- `Visualisation` - Documented transformation of Linked Art JSON-LD to data visualisation

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
https://nbviewer.org/
> nbviewer is an online service that will render a static view of a Jupyter notebook using a URL. An example of [the IMA transformation notebook via nbviewer](https://nbviewer.org/github/tgra/Linked-Art/blob/04226e1b9dd8fd46aa39db46cac213dbc5b09c89/jupyter_notebooks/IMA%20-%20From%20Catalogue%20Data%20to%20Linked%20Art.ipynb). 

### GitHub 
> Github offers a static view of a Jupyter Notebook. Viewing the file in GitHub is simply a matter of selecting the relevant *.iynb file in the `jupyter_notebooks` folder

---
## Documented Interactive Code Jupyter Notebooks
The different types of Jupyter notebooks:

### Data Model Parts
Interactive, documented code transformations for parts of the Linked Art Data Model.
1. [Core Properties](./jupyter_notebooks/Core-Properties.ipynb)

## Collections Data
>Interactive, documented code transformations using read-world collections data.

#### Indianapolis Museum of Art
>These notebooks use sample data published by the Indianapolis Museum of Art (IMA) as data input. The transformation is based on an XSLT file published by the IMA.

Download
1. [Indianapolis Museum of Art - Transformation of a selected artwork](./jupyter_notebooks/Transforming_Collections_to_Linked_Art_IMA_Selected_Artwork.ipynb)
2. [Indianapolis Museum of Art - Transformation of all artworks](./jupyter_notebooks/Transforming_Collections_to_Linked_Art_IMA_All_Artworks.ipynb) 

View via nbviewer
1. [Indianapolis Museum of Art - Transformation of a selected artwork](https://nbviewer.org/github/tgra/Linked-Art/blob/main/jupyter_notebooks/Transforming_Collections_to_Linked_Art_IMA_Selected_Artwork.ipynb)
2. [Indianapolis Museum of Art - Transformation of all artworks](https://nbviewer.org/github/tgra/Linked-Art/blob/main/jupyter_notebooks/Transforming_Collections_to_Linked_Art_IMA_All_Artworks.ipynb)

View via Binder
1. Indianapolis Museum of Art - Transformation of a selected artwork [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/blob/main/jupyter_notebooks/Transforming_Collections_to_Linked_Art_IMA_Selected_Artwork.ipynb/HEAD)
2. Indianapolis Museum of Art - Transformation of all artworks [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tgra/Linked-Art/blob/main/jupyter_notebooks/Transforming_Collections_to_Linked_Art_IMA_All_Artworks.ipynb/HEAD)

## Availability

All of the Jupyter notebooks can be downloaded as a [zip file](https://github.com/tgra/Linked-Art/archive/refs/heads/main.zip) or checked out of the Github repository:
- [https](https://github.com/tgra/Linked-Art.git)
- GitHub client `gh repo clone tgra/Linked-Art`

Alternatively, they can be [viewed directly on GitHub](https://github.com/tgra/Linked-Art/tree/main/jupyter_notebooks). 
