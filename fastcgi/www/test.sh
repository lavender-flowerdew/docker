#! /bin/bash

d=`ls -l /`

echo "Content-Type: text/html\n\n"
echo ""
echo ""
echo "<html> <head>"
echo "<title>Hello, world!</title>"
echo "</head>"
echo "<body>"
echo '<pre>'
/usr/bin/env
echo "<h1>Hello, world!</h1>"
echo "$d"
echo '</pre>'
echo "</body> </html>"

exit 0
