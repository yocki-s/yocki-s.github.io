Thunder is the documentation project for Veritrans API. Target audiences are merchants and their web developers. 

Requirements:
* Ruby >= 1.9.3 
* Middleman gem >=3.2.0 

Middleman is a static site generator.

## How to run Middleman server
* Run ```bundle exec middleman``` from inside project folder in command-line.
* Open generated website in your [web browser](http://localhost:4567).

## How to Update Documentation
* Run ```bundle exec middleman build``` from inside project folder in command-line.
* A static website will be generated in the `public` folder.
* Copy the content of the `public` folder and paste it into [veritrans.github.io](https://github.com/veritrans/veritrans.github.io) local repo in your computer. **IMPORTANT:** _Delete all files inside the local github.io folder_ ***EXCEPT*** _`CNAME` and `sitemap.xml`_
* Run `commit` and `push` **without** pulling first.

## How to Create New Page
* Add new link in `/data/navigation.json`.
* Create the page in the appropriate folder.

## Style guide
* Use `markdown` instead of HTML whenever possible.
* Upload content for both languages instead of one-by-one. 
