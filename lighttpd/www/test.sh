#! /bin/bash

d=`ls -l /`

echo "Content-Type: text/html\n\n"
echo ""
echo ""
echo "<html> <head>"
echo "<title>Hello, world!</title>"
echo "</head>"
echo "<body>"
echo "<h1>Hello, world!</h1>"
echo "$d"
echo '<pre>'
/usr/bin/env
echo '</pre>'

echo "</body> </html>"

exit 0
