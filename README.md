# CRAFT corpus experiments

Corpus homepage: http://bionlp-corpora.sourceforge.net/CRAFT/

## Data preparation

* Standoff data originally downloaded from http://compbio.ucdenver.edu/Craft/

* Split into test and train-and-devel:
  * Run `scripts/annotation-counts.sh` to get annotation counts
  * Run `scripts/split-by-majority-type.sh` to divide into strata by most
    frequent type
  * Run `scripts/split-test-set.sh` to split off random 1/3 as test set

* Eliminate duplicate annotations:
  * Run `scripts/remove-all-duplicates.sh` to deduplicate .ann files
  * Check number of changes:

```
diff -r train-and-devel-standoff-separated train-and-devel-standoff-separated-deduplicated/ | egrep '^<' | wc -l
1016
```

## Parameter selection

* Run `scripts/separate-standoff.sh` to create separate standoff files for each
  annotation type
* Run `scripts/select-parameters.sh` to run parameter selection using
  cross-validation on the training-and-development data

## References

* Bada, M., Eckert, M., Evans, D., Garcia, K., Shipley, K., Sitnikov, D., Baumgartner Jr., W. A., Cohen, K. B., Verspoor, K., Blake, J. A., and Hunter, L. E. [Concept Annotation in the CRAFT Corpus](http://www.biomedcentral.com/1471-2105/13/161). BMC Bioinformatics. 2012 Jul 9;13:161. doi: 10.1186/1471-2105-13-161

* Verspoor, K., Cohen, K.B., Lanfranchi, A., Warner, C., Johnson, H.L., Roeder, C., Choi, J.D., Funk, C., Malenkiy, Y., Eckert, M., Xue, N., Baumgartner Jr., W.A., Bada, M., Palmer, M., Hunter L.E. [A corpus of full-text journal articles is a robust evaluation tool for revealing differences in performance of biomedical natural language processing tools](http://www.biomedcentral.com/1471-2105/13/207). BMC Bioinformatics. 2012 Aug 17;13(1):207. 
