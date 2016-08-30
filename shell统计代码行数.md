#### 去空格去注释

    find . -name "*.go"|xargs cat|grep -v -e ^$ -e ^\s*\/\/.*$|wc -l    #Output:36064  
