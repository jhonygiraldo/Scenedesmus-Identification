# Automatic Identification of Scenedesmus Polymorphic Microalgae from Microscopic Images
By Jhony‐Heriberto Giraldo‐Zuluaga, Augusto Salazar, German Diez, Alexander Gomez, Tatiana Martínez, J. F. Vargas, Mariana Peñuela

**Abstract**: Microalgae counting is used to measure biomass quantity. Usually, it is performed in a manual way using a Neubauer chamber and expert criterion, with the risk of a high error rate. Scenedesmus algae can build coenobia consisting of 1, 2, 4 and 8 cells. The amount of algae of each coenobium helps to determine the amount of lipids, proteins, and other substances in a given sample of a algae crop. The knowledge of the quantity of those elements improves the quality of bioprocess applications. This paper addresses the methodology for automatic identification of Scenedesmus microalgae (used in the methane production and food industry) and applies it to images captured by a digital microscope. The use of contrast adaptive histogram equalization for pre-processing, and active contours for segmentation are presented. The calculation of statistical features (Histogram of Oriented Gradients, Hu and Zernike moments) with texture features (Haralick and Local Binary Patterns descriptors) are proposed for algae characterization. Classification of coenobia achieves accuracies of 98.63% and 97.32% with Support Vector Machine (SVM) and Artificial Neural Network (ANN), respectively. According to the results it is possible to consider the proposed methodology as an alternative to the traditional technique for algae counting. In addition, the database used for the developing of the proposed methodology is publicly available.

## Citing Scenedesmus-Identification

If you find Scenedesmus-Identification useful in your research, please consider citing:

 ```
 @Article{giraldo2017automatic,
  author="Giraldo-Zuluaga, Jhony-Heriberto and Salazar, Augusto and Diez, German and Gomez, Alexander and Mart{\'i}nez, Tatiana and Vargas, J. F. and Pe{\~{n}}uela, Mariana",
	title="Automatic identification of Scenedesmus polymorphic microalgae from microscopic images",
	journal="Pattern Analysis and Applications",
  pages={1--12},
  year={2017},
  publisher={Springer}
}
```

## Database

File *Microalgae Database.zip* contains the database used in the paper *Automatic identification of Scenedesmus polymorphic microalgae from microscopic images*. The database is publicly available for academic and research purposes.

## Requirements: software

The codes used the [Balu Toolbox Matlab](http://dmery.ing.puc.cl/index.php/balu).
