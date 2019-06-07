ESX Raid Check WWW Example

<p>

<?php
//Open directory
$dir = dir("raids");

//List files in directory
while (($file = $dir->read()) !== false){
        //Make sure it's a .txt file
        if(strlen($file) < 5 || substr($file, -4) != '.txt')
                continue;
        echo "<p> filename: " . $file . "<br />";
        include('raids/'.$file) ;
        echo "</p>";
}

$dir->close();
?>
