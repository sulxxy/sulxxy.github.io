title: GAWK usages
date: 2016-04-27 10:29:34
tags: [Linux, Shell]
---

# Introduction
---
**AWK** programming language is a powerful pattern matching language and it is often used to process text. **GAWK** is the GNU implementation of AWK. This post mainly talks about the most basic grammars and usages of AWK. The complete manual of GAWK is [here](http://www.gnu.org/software/gawk/manual/gawk.html).

# Record, Field
The input is read in units called **records**, and is processed by the rules of your program one record at a time. By default, each record is one line. Each record is automatically split into chunks called **fields**. This makes it more convenient for programs to work on the parts of a record.

## Record splitting
Records are separated by a character called the *record separator*. By default, the record separator is the newline character. This is why records are, by default, single lines. To use a different character for the record separator, simply assign that character to the predefined variable **RS**.

**NR** is predefined variable, which records the total number of input records read so far from all data files. 

## Field splitting
When AWK reads an input record, the record is automatically parsed or separated by the AWK utility into chunks called *fields*. By default, fields are separated by *whitespace*, like words in a line. Whitespace in AWK means any string of one or more spaces, TABs, or newlines; other characters that are considered whitespace by other languages(such as formfeed, vertical tab, etc.) are not considered whitespace by AWK.

You use a dollar sign ( '\$' ) to refer to a field in an AWK program, followed by the number of the field you want. Thus, \$1 refers to the first field, \$2 to the second, and so on. 

The use of \$0, which looks like a reference to the "zeroth" field, is a special case: it represents the whole input record. Use it when you are not interested in specific fields.

**NF** is a predefined variable whose value is the numbers of fields in the current record. AWK automatically updates the value of **NF** each time it reads a record. No matter how many fields there are, the last field in a record can be represented by **$NF**.

# Variables, actions, patterns 
---
## GAWK built-in variables
1. NF: the numbers of fields in current record
2. NR: the numbers of records
3. FS: field separator 
4. RS: record separator
5. OFS: field separator of output
6. ORS: record separator of output
7. FILENAME: the filename of input file

## The **BEGIN** and **END** patterns
The BEGIN and END special patterns supply startup and cleanup actions. A BEGIN rule is executed once only, before the first input record is read. Likewise, an END rule is executed once only, after all the input is read. For example:
{% codeblock %}
$ awk '
> BEGIN { print "Analysis of \"li\""}
> /li/ {++n}
> END { Print "\li"li\" appears in ", n, "records." }' mail-list
-| Analysis of "li"
-| "li" appears in 4 records.
{% endcodeblock %}

This program finds the number of records in the input file mail-list that contain the string ‘li’. The BEGIN rule prints a title for the report. There is no need to use the BEGIN rule to initialize the counter n to zero, as awk does this automatically (see Variables). The second rule increments the variable n every time a record containing the pattern ‘li’ is read. The END rule prints the value of n at the end of the run.

## Regular expressions
A regular expression can be used as a pattern by enclosing it in slashes. Then the regular expression is tested against the entire text of each record. (Normally, it only needs to match some part of the text in order to succeed.) For example, the following prints the second field of each record where the string ‘li’ appears anywhere in the record:
{% codeblock %}
$ awk '/li/ {print $2 }' mail-list
-| 555-5553
-| 555-0542
{% endcodeblock %}

Regular expressions can also be used in matching expressions. These expressions allow you to specify the string to match against; it need not be the entire current input record. The two operators '-' and '!-' perform regular expression comparisons. Expressions using these operators can be used as patterns, or in if, while, for, and do statements. For example, the following is true if the expression *exp* (taken as a string) matches *regexp*:
> exp - /regexp/

This example matches, or selects, all input records with the uppercase letter 'J' somewhere in the first field:
{% codeblock %}
$ awk '$1, -/J/' inventory-shipped
-| Jan 12 25 15 115
-| Jun 31 42 75 492
{% endcodeblock %}

The next example is true if the expression *exp* (taken as a character string) does *not* natch *regexp*:
> exp!- /regexp/

The following example matches, or selects, all input records whos first field does not contain the uppercase letter 'J':
{% codeblock %}
$ awk '$1, !- /J/' inventory-shipped
-| Apr 12 25 15 115
-| Feb 31 42 75 492
{% endcodeblock %}

## Dictionary
The awk language provides one-dimensional arrays for storing groups of related strings or numbers. Every awk array must have a name. Array names have the same syntax as variable names; any valid variable name would also be a valid array name. But one name cannot be used in both ways (as an array and as a variable) in the same awk program.

The index of an array is exclusive. However, any number, or even a string, can be an index. As a result, the array in AWK is something like dictionary. So, we can delete the repeated words in a file using array:
{% codeblock %}
$ echo "aaa bbb ccc" > testfile
$ gawk '{for(i=1;i<=NF;i++){if(arr[$i]++) $i=""}} END {print }' testfile
$ aaa bbb
{% endcodeblock %}

# Functions
---
## gsub(regexp, replacement [, target])
Search target for all of the longest, leftmost, nonoverlapping matching substrings it can find and replace them with replacement. The ‘g’ in gsub() stands for “global,” which means replace everywhere. For example:
> { gsub(/Britain/, "United Kingdom"); print }

replaces all occurrences of the string ‘Britain’ with ‘United Kingdom’ for all input records.

The gsub() function returns the number of substitutions made. If the variable to search and alter (target) is omitted, then the entire input record ($0) is used. As in sub(), the characters ‘&’ and ‘\’ are special, and the third argument must be assignable.

## gensub(regexp, replacement, how [, target]) 
Search the target string target for matches of the regular expression regexp. If how is a string beginning with ‘g’ or ‘G’ (short for “global”), then replace all matches of regexp with replacement. Otherwise, how is treated as a number indicating which match of regexp to replace. If no target is supplied, use $0. It returns the modified string as the result of the function and the original target string is not changed.

gensub() is a general substitution function. Its purpose is to provide more features than the standard sub() and gsub() functions.

gensub() provides an additional feature that is not available in sub() or gsub(): the ability to specify components of a regexp in the replacement text. This is done by using parentheses in the regexp to mark the components and then specifying ‘\N’ in the replacement text, where N is a digit from 1 to 9. N means the matching contents of the regular expression in the Nth parenthesis. For example:
{% codeblock %}
$ gawk '
> BEGIN {
> 	a = "abc def ghi"
> 	b = gensub(/(abc) (def)/, "\\2", "g", a)
> 	print b
> }'
-| def ghi
{% endcodeblock %}

\\\2 means the matching result of the regular expression of the second parenthesis("(def)"). 

As with sub(), you must type two backslashes in order to get one into the string. In the replacement text, the sequence ‘\0’ represents the entire matched text, as does the character ‘&’.



