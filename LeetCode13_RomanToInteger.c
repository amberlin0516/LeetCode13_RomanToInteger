#include<stdio.h>
int transINT(char c)
{
    if(c == 'I')
        return 1;
    else if(c == 'V')
        return 5;
    else if(c == 'X')
        return 10;
    else if(c == 'L')
        return 50;
    else if(c == 'C')
        return 100;
    else if(c == 'D')
        return 500;
    else
        return 1000;
}

int romanToInt(char * s){
    int i;
    int n_size = 0;
    int sum;
        
    //strSize
    i = 0;
    while(s[i] != '\0')
    {
        n_size++;
        i++;
    }
    
    sum = transINT(*(s+n_size-1)); 
    //the rightest element n[n_size-1] must be added in sum
    //if sum = 0, it would be out of bound in forloop
    for(i = (n_size-1); i > 0  ; i--)
    {
        int cur = transINT(*(s+i));
        int pre = transINT(*(s+i-1));
        
        if(cur < pre)
            sum += pre;
        else
            sum -= pre;
    }
    return sum;
}

int main()
{
    char s[] = "MCMXCIV";
    int number;
    
    number = romanToInt(s);
    printf("%d", number);
    
    //system("PAUSE");	
    return 0;
}