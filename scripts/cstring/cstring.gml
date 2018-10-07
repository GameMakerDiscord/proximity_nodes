///@desc trace(value,...)
///@arg values(plural_possible!)
/* === Shorter debug_messager => console log; === */
// concenacts arguments into one string, with a seperator!
var i,s="";
for(i=0;i<argument_count;i++){
    s+=string(argument[i]);
}  
return s;
