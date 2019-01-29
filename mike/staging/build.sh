#!/bin/bash
cd posts/ #invoked from staging/
#assemble index from HTML chunks
html="<ul>"
for post in $(find * | sort -r);do html=$html"<li><a href=\"$post.htm\">$post</a></li>"; done
html=$html"</ul>"
printf '%s\n' "$html" | cat ../top.template - ../bot.template > ../../index.html
#assemble all the blog pages from all the chunks
for post in $(find * | sort -r);do cat ../top.template $post ../bot.template > ../../$post.htm; done
#assemble atom feed from all the chunks
atom_header=$(cat <<EOM
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
<title>Mike Putnam</title>
<link rel="self" type="application/atom+xml" href="https://theputnams.net/mike/feed.atom"/>
<updated>$(date -I)T00:00:00Z</updated>
<id>https://theputnams.net/mike/</id>
<author>
<name>Mike Putnam</name>
<email>mike@theputnams.net</email>
</author>
EOM
)
#
for post in $(find * | sort -r);
do
atom_entries=${atom_entries}$(cat <<EOM
<entry>
<title>$post</title>
<link href="https://theputnams.net/mike/$post.htm"/>
<id>https://theputnams.net/mike/$post.htm</id>
<updated>$(echo $post |cut -c1-10)T00:00:00Z</updated>
<summary> </summary>
</entry>
EOM
)
done
#
atom_footer=$(cat <<EOM
</feed>
EOM
)
echo $atom_header$atom_entries$atom_footer > ../../feed.atom
cd ../../../ #root of repo
