# download and parse the MIT OpenCourseWare website,
# parse the course websites to XML and dump them to the standard output
url_root='http://ocw.mit.edu'
id_url_file='id.url.txt'
output_root='materials'
previous_id='null'
ext_talbe_script='/home/quark/MIT/links/ext.table.py'

download_syllabus () {
wget $url/"syllabus"/ -O syllabus.htm
if [ $? -ne 0 ] ; then
	wget $url/"Syllabus"/ -O syllabus.htm
fi
}
download_zips () {
wget $url/"download-course-materials"/ -O download.htm.$$
wget $url_root`grep -o "/.*.zip" download.htm.$$`
rm download.htm.$$
}
unzip_zips () {
if [ -f *.zip ] ; then
unzip *.zip
fi
}
# print the XML format meta data to standard output
# the code is not delicate enough to handle all wired cases.
extract_metadata () {
if [ `ls *.zip | wc -l` -ne 0 ] ; then
	content_dir=`ls *.zip | cut -d '.' -f1`
	if [ -d "$content_dir" ] ; then
		pushd $content_dir/"contents" >> /dev/null
		echo '<course>'
		echo ' <id>'$id'</id>'
		title=`grep "<title>.*|.*|.*</title>" index.htm`
		echo ' <name>'`echo $title | cut -d '|' -f1 | cut -d '>' -f2`'</name>'
		echo ' <tag>'`echo $title | cut -d '|' -f2`'</tag>'
		echo ' <keywords>'`grep keywords index.htm | cut -d \" -f2`'</keywords>'
		if [ -d "calendar" ] ; then
			pushd "calendar" >> /dev/null
			echo ' <calendar>'`python2.7 $ext_talbe_script index.htm`'</calendar>'
			popd >> /dev/null
		fi
		echo '</course>'
		popd >> /dev/null
	fi
fi
}

while read line
do
	id=`echo $line | cut -d ' ' -f1`
	url=`echo $line | cut -d ' ' -f2`

	# only keep the most recent course
	if [ "$id" != "$previous_id" ] ; then
		workspace="$output_root/$id"
		mkdir -p $workspace && pushd $workspace >> /dev/null

		# write down what we want to do with the url
		extract_metadata

		popd >> /dev/null
		previous_id=$id
	fi
done < $id_url_file
