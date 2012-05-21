cd posts
#assemble sitemap from HTML chunks
html="<ul>" 
for post in `find * | sort -r`;do html=$html"<li><a href=\"$post.htm\">$post</a></li>"; done
html=$html"</ul>" 
printf '%s\n' "$html" | cat ../top.template - ../bot.template > ../../sitemap.htm
#find the most recent HTML chunk and make that the index.html
for latest in `find * | sort -r | head -n 1`;do cat ../top.template $latest ../bot.template > ../../index.html; done
#assemble all the blog pages from all the chunks
for post in `find * | sort -r`;do cat ../top.template $post ../bot.template > ../../$post.htm; done
