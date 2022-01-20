# General Use

Code in this repository is useful for many applications outside of NGS data analysis. 

# read-ini 

The read-ini command reads a config.ini file and outputs the specified key within the specified section. This allows one to assign ini variables to a bash variable, which is useful when using comand line interface. I've provided both a compiled binary and source code of this command. 
```
#binary:
read-ini [arg1] [arg2] [arg3]
Arguments:
         arg1 = config.ini file
         arg2 = section (defined in ini file with [])
         arg3 = variable key (within the section)
         
#source code:
./read-ini.sh [arg1] [arg2] [arg3]
Arguments:
         arg1 = config.ini file
         arg2 = section (defined in ini file with [])
         arg3 = variable key (within the section)
```        
## Tutorial
An example config.ini file:
```
$ cat config.ini
[FANTOM]
path=/data/hodges_lab/ATAC-STARR_B-cells/data/hansen-fong/fantom
erna_all=/data/hodges_lab/ATAC-STARR_B-cells/data/hansen-fong/fantom/hg38.enhancers.bed

[RESULTS]
path=/data/hodges_lab/ATAC-STARR_B-cells/results/results_human-evolution/fantom-comparison
``` 
To extract the _path_ variable from _[FANTOM]_:
```
$ read-ini config.ini FANTOM path
/data/hodges_lab/ATAC-STARR_B-cells/data/hansen-fong/fantom
```
To assign to variable: 
```
$ var=$(read-ini config.ini FANTOM path)
$ echo $var
/data/hodges_lab/ATAC-STARR_B-cells/data/hansen-fong/fantom
```
