# Scraping HTML with Nokogiri

## Objectives

1. Introduce web scraping and its usages. 
2. Learn how to use Nokogiri to scrape data from an HTML document. 

## Introduction

In previous lessons we've become familiar with working with APIs in order to retrieve data from external resources. You may have seen, for example, the process of sending an HTTP request to an API and receiving data back from that API in JSON format. You may also have seen the Twitter gem used to request data from Twitter. 

However, there is yet another way for our Ruby programs to retrieve data from external sources: web scraping. Web scraping is the act of parsing a web page's HTML and pulling, or "scraping" pertinent data from that HTML. In this reading, we'll take a brief look at what scraping is and how to accomplish it. Then, we'll move on to a scraping code along exercise. 

## What is Scraping and Why Use it?

As we established above, scraping is a technique used to grab data out of the HTML that makes up a web page. Scraping can be difficult to accomplish––in order to get the data we want, we need to closely examine the HTML and identify exactly which elements contain the information we're interested in. It requires a high degree of precision. 

So, if scraping is so tricky, why do we use it? Well, not all of the data we might be interested in using to program is available to use through APIs. For example, let's say we're creating an app that catalogues popular musicians and searches the web for their upcoming concerts. A quick Google search will reveal that, unfortunately for us, there isn't a "Popular Musician" API out there just waiting to be used. There is however, a very comprehensive list of musicians on the Billboard website. In such a scenario, you may want to programmatically grab every musician's name from the Billboard list and store those artists in your own database. 

Here's another example: let's say you're creating an app that allows a user to subscribe to a news feed. You anticipate that your users are super-tech savvy and might be interested in subscribing to some lesser-known tech news sites. Such sites may not have an API that makes their articles available to you. Instead, you would have to scrape those sites for their latest news articles and send those newest articles to your users. 

These are just a few examples of situations in which scraping might come in handy. Now that we have a few use-cases that illustrate the utility of scraping, let's talk about *how* to scrape. 

## Scraping HTML Using Nokogiri and Open-URI

### Refresher: What is Open-URI?

Open-URI is a module in Ruby that allows us to programmatically make HTTP requests. It gives us a bunch of useful methods to make different types of requests, but for this guide, we're interested in only one: `open`. This method takes one argument, a URL, and will return to us the HTML content of that URL.

In other words, running:

```ruby
html = open('http://www.google.com')
```

stores the HTML of Google into a variable called html. (More specifically, it actually stores the HTML in a temporary file that we can then call read on to get the raw HTML. We won't worry about that here though.)

### What is Nokogiri?

Nokogiri is a Ruby gem that helps us to parse HTML and collect data from it. Essentially, Nokogiri allows us to treat a huge string of HTML as if it were a bunch of nested nodes. In doing so, Nokogiri offers you, the programmer, a series of methods that you can use to extract the desired information from these nested nodes. Nokogiri makes the level of precision required to extract the necessary data much easier to attain. It works like a fine-toothed saw to scrape only the necessary data. In fact, that's what "nokogiri" means: a fine-toothed saw.

![](http://readme-pics.s3.amazonaws.com/akaisora309838.jpg)

Let's get Nokogiri up and running and look at a very basic example of its usage. Then, we'll move on to the next lesson, where you'll try it out for yourself. 

### Installing Nokogiri

Installing Nokogiri is as easy as `gem install nokogiri`. If you run into any issues with this, check out the following documentation: [*Nokogiri Installation Guide*](http://www.nokogiri.org/tutorials/installing_nokogiri.html). 

### Opening a Web Page as HTML with Nokogiri and open-uri

Let's say we have a file, `scraper.rb` which is responsible for (you guessed it) scraping. We need to require Nokogiri and open-uri: 

```ruby
require 'nokogiri'
require 'open-uri'

#more code coming soon!
```

We can use the following line to grab the HTML that makes up the Flatiron School's landing page at flatironschool.com: 

```ruby
html = open("https://flatironschool.com/")
```

Next, we'll use the ` Nokogiri::HTML` method to take the string of HTML returned by open-uri's `open` method and convert it into a NodeSet (aka, a bunch of nested "nodes") that we can easily play around with.

```ruby
Nokogiri::HTML(html)
```

Let's save the HTML document in a variable, `doc` that we can then operate on: 

```ruby
doc = Nokogiri::HTML(html)
```

If we were to `puts` out `doc` right now, we'd see something like this in our terminal: 

```bash
<!DOCTYPE html>
<html> <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"> <meta charset="utf-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head> 
<body> <div class="wrapper"> <header id="header"> <div class="nav-holder holder"> <strong class="logo"><a href="/"><img src="images/logo.png" alt="The Flatiron School"></a></strong> <nav id="nav"> <a href="#" class="opener"><span></span></a> <div class="drop"> <div class="drop-holder"> <ul class="top-nav"> <li class="active hide_mobile"><a href="http://go.flatironschool.com/apply" target="_blank">Apply</a></li> <li class="hide_mobile"><a href="/hire">Partner</a></li> <li class="hide_mobile"><a href="http://precollege.flatironschool.com" target="_blank">Precollege</a></li> <li class="hide_mobile"><a href="http://blog.flatironschool.com/" target="_blank">Blog</a></li> <li class="hide_mobile"><a href="/contact">Contact</a></li> <li class="hide_mobile"><a href="/careers">We're hiring!</a></li> </ul> <ul class="main-nav mega-menu-nav"> <li> <a href="/school">The School</a> <div class="megamenu"> <div class="column quote-container"> <div class="tab-content"> <div id="tab7"> <blockquote> <q>“Best of luck to the new @FlatironSchool group. Looking back, you'll categorize your life as before today and after today.”</q> <cite> <a href="https://twitter.com/mcnameekm/status/298577378274336772" class="twitter"> <span class="icon-twitter"></span> </a> <span class="photo"><span data-picture data-alt="image description"> <span data-src="images/kevin_mcnamee.png"></span> <span data-src="images/kevin_mcnamee.png" data-media="(-webkit-min-device-pixel-ratio:1.5), (min-resolution:1.5dppx)"></span> <!--[if (lt IE 9) & (!IEMobile)]>
<!-- ... more HTML ... -->
</body> </html>
```

Gah! I know this looks awful. It kind of is. But don't worry! Nokogiri will help us parse this. What we're looking at here is all of the HTML that makes up the web page found at [www.flatironschool.com](http://flatironschool.com/). The massive lines above are actually a snapshot of that HTML converted into a structure of nested nodes by Nokogiri. 

#### What are Nested Nodes?

Nested nodes refers to any tree of elements in which parent elements branch off to contain children elements. In fact, we've seen similarly nested structures before when we dealt with nested data structures like hashes. By creating a nested structure, Nokogiri allows us to do things like iterate over a collection of elements from the HTML document and use brackets,`[]`, and dot notation to access elements within the nested structure. 

### Using Nokogiri to Extract Data 

*Note: For this reading, we'll be using the Flatiron School website. However, how you scrape a page is **very specific to the content of the page you are trying to scrape**. That means that if the webpage you wrote certain scraping code for ever changes, your scraping code will likely no longer work correctly. So, the Flatiron School website that this reading refers to *may have changed*! Therefore some of the examples here, if they are specific to an earlier version of the site, won't work for you to try out on your own. That's okay though. Just follow along with the reading and, if you want to try it out, feel free to use the examples provided to guide you in scraping content that is present on the page. There will be plenty more exercises for you to try out, coming right up.*

Visit [this Flatiron School link](http://flatironschool.com/) and use your browser's developer tools to inspect the page. (You can just right-click anywhere on the page and select "inspect element".)

You should see something like this: 

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-19%20at%205.58.16%20PM.png)

The element inspector view on the bottom half of the page is revealing all of the page's HTML to us! In fact, the HTML it is showing us is *exactly the same* as the HTML `put` out to our terminal with the help of Nokogiri and open-uri.  

Now that we understand what Nokogiri is and seen how it opens the HTML that makes up a web page, let's look at how we use it to actually scrape information. 

### Using CSS Selectors to Get Data 

Nokogiri allows you to use CSS selectors in order to retrieve specific pieces of information out of an HTML document. 

#### What is a CSS Selector

In the following code: 

```html
<div id="my-div">
  <p class="my-paragraph"></p>
</div>
```

The id and class attributes of the HTML elements are the CSS selectors. You would refer to the div with this selector: `#my-div` (using the `#` to indicate id), and the paragraph with this selector: `.my-paragraph` (using the `.` to indicate class).

#### Nokogiri's `.css` Method

Nokogiri's `.css` method can be called on the `doc` variable that we set equal to that giant string of HTML that Nokogiri retrieved for us. The `.css` method takes in an argument of the CSS selector you want to retrieve. Let's take a look. 

#### Choosing a CSS Selector

How do we determine which selector to use to retrieve the desired information? Remember that the HTML document that Nokogiri retrieved for us to operate on is *exactly the same* HTML that makes up the web page. Let's go back to [www.flatironschool.com](http://www.flatironschool.com) and use the element inspector to find the selector of a certain piece of information: 

![](http://readme-pics.s3.amazonaws.com/Screen%20Shot%202015-08-19%20at%206.11.34%20PM.png)

This nice, big, bold statement, "350+ lives changed, and counting.", looks like a pretty good candidate. 

In order to identify its CSS selector, you click on the magnifying glass icon on the top left of the element inspector view and hover it over the element we want to ID ("350+ lives changed, and counting.")

That highlights its HTML element for us. Notice that: 

```html
<span class="grey-text">...</span>
```

is highlighted in the above image. If you click on the carrot at the left end of that line, it will open up to show you what that element contains: 

```html
"350+ lives changed, and counting."
```

We found it! That text lives in a span whose class is `"grey-text"`. Now we're ready to use the `.css` method to grab the text we want: 

#### Calling the `.css` method

In our `scraper.rb` file, we had the following code: 

```ruby
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://flatironschool.com/"))
```

Let's call `.css` on `doc` and give it the argument of our CSS selector: 

```ruby
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://flatironschool.com/"))
doc.css(".grey-text")
```

If we `puts` out the result of that method call: 

```ruby
puts doc.css(".grey-text")
```

We'd see something like this: 

```bash
[#<Nokogiri::XML::Element:0x3ff8bdcc1a64 name="span" attributes=[#<Nokogiri::XML::Attr:0x3ff8bdcc19d8 name="class" value="grey-text">] children=[#<Nokogiri::XML::Text:0x3ff8bdcc12d0 "350+ lives changed,">, #<Nokogiri::XML::Element:0x3ff8bdcc11e0 name="br">, #<Nokogiri::XML::Text:0x3ff8bdcc0ee8 "and counting.">]>]
```

Okay, still kind of gross. But we're almost there. If you look closely at the element above, you'll notice this: 

```bash
children=[#<Nokogiri::XML::Text:0x3ff8bdcc12d0 "350+ lives changed,">,
#<Nokogiri::XML::Element:0x3ff8bdcc11e0 name="br">,
#<Nokogiri::XML::Text:0x3ff8bdcc0ee8 "and counting.">]
```

There's our text! Buried in there. To get it out, we can call `.text` on it: 

```ruby
doc.css(".grey-text").text
 => "350+ lives changed,and counting."
```

We did it! We used Nokogiri to get the HTML of a web page. We used the element inspector in the browser to ID the CSS selector of the data we wanted to scrape. We used the `.css` Nokogiri method, along with that CSS selector, to grab the element that contains our desired data. Finally, we used the `.text` method to retrieve the desired text. 

This was only a brief introduction into the concept and mechanics of scraping. We'll be taking a closer look in the upcoming code along exercise. Keep in mind that scraping is difficult and takes a lot of practice.

### Iterating over elements

Sometimes we want to get a collection of the same elements, so we can iterate over them.

Let's first get a list of the instructors from the [flatironschool.com/team](https://web.archive.org/web/20160227204808/http://flatironschool.com/team) page.

```ruby
require 'nokogiri'
require 'open-uri'

html = open("https://web.archive.org/web/20160227204808/http://flatironschool.com/team")
doc = Nokogiri::HTML(html)

instructors = doc.css("#instructors .team-holder .person-box")
```

Even though the Nokogiri gem returns a `Nokogiri::XML::Element` (which looks like an array in ruby), we can use Ruby methods, such as `.each` and `.collect`, to iterate over it.


```bash
[#<Nokogiri::XML::Attr:0x3fcd82a22b84 name="class" value="icon-github2">]>]>]>, #<Nokogiri::XML::Text:0x3fcd82a238b8 " ">, #<Nokogiri::XML::Element:0x3fcd82a1feac name="li" children=[#<Nokogiri::XML::Element:0x3fcd82a1faec name="a" attributes=[#<Nokogiri::XML::Attr:0x3fcd82a1f8a8 name="href" value="http://twitter.com/aviflombaum">, #<Nokogiri::XML::Attr:0x3fcd82a1f894 name="target" value="_blank">] children=[#<Nokogiri::XML::Element:0x3fcd82a1ebb0 name="span" attributes=[#<Nokogiri::XML::Attr:0x3fcd82a1eb10 name="class" value="icon-twitter2">]>]>]>, #<Nokogiri::XML::Text:0x3fcd82a1be88 " ">, #<Nokogiri::XML::Element:0x3fcd82a1bd20 name="li" children=[#<Nokogiri::XML::Element:0x3fcd82a1b8d4 name="a" attributes=[#<Nokogiri::XML::Attr:0x3fcd82a1b85c name="href" value="http://www.facebook.com/aviflombaum">, #<Nokogiri::XML::Attr:0x3fcd82a1b848 name="target" value="_blank">] children=[#<Nokogiri::XML::Element:0x3fcd82a1ad58 name="span" attributes=[#<Nokogiri::XML::Attr:0x3fcd82a1acf4 name="class" value="icon-facebook2">]>]>]>, #<Nokogiri::XML::Text:0x3fcd82a1a470 " ">, #<Nokogiri::XML::Element:0x3fcd82a1a394 name="li" children=[#<Nokogiri::XML::Element:0x3fcd82a1a0d8 name="a" attributes=[#<Nokogiri::XML::Attr:0x3fcd82a1b9d8 name="href" value="http://www.linkedin.com/in/aviflombaum">, #<Nokogiri::XML::Attr:0x3fcd82a1a9e8 name="target" value="_blank">] children=[#<Nokogiri::XML::Element:0x3fcd82a17734 name="span" attributes=[#<Nokogiri::XML::Attr:0x3fcd82a176bc name="class" value="icon-linkedin2">]>]>]>, #<Nokogiri::XML::Text:0x3fcd82a16e38 " ">]>, … ]
```


Let's iterate over the instructors array with `.each` and `puts` out `"Flatiron School <3 "` followed by an instructor's name.

```ruby
instructors.each do |instructor| 
  puts "Flatiron School <3 " + instructor.css("h2").text
end
```

We'd see something like this:

```bash
Flatiron School <3 Avi Flombaum
Flatiron School <3 Joe Burgess
…
…
…
```


### Advanced: Operating on XML

Let's take another look at the element returned to us by our call on the `.css` method: 

```bash
[#<Nokogiri::XML::Element:0x3ff8bdcc1a64 name="span" attributes=[#<Nokogiri::XML::Attr:0x3ff8bdcc19d8 name="class" value="grey-text">] children=[#<Nokogiri::XML::Text:0x3ff8bdcc12d0 "350+ lives changed,">, #<Nokogiri::XML::Element:0x3ff8bdcc11e0 name="br">, #<Nokogiri::XML::Text:0x3ff8bdcc0ee8 "and counting.">]>]
```

This is an XML element. XML stands for Extensible Markup Language. Just like HTML, it is a set of rules for encoding and displaying data on the web. When we use Nokogiri methods, we get a return value of XML elements, collected into an array. Technically, methods like `.css` return a Nokogiri data object that is a collection of Nokogiri::XML::Element objects that *functions* like an array.  

The main thing to understand, however, is that Nokogiri collects these objects into hierarchical data structures, much like the nested arrays and hashes we've been building and manipulating for a while now. So, we could iterate over an array of Nokogiri objects, use enumerators, grab the values of attributes that act as hash keys, etc. We'll get practice with all of this in the upcoming exercise. 

## Resources

* Scraping is a big topic, and it takes *a lot* of practice to get comfortable doing it. The below resource is a great place to learn more about scraping and even get some practice with simple examples. If you felt really confused by this reading, we recommend checking it out before moving on. 
  - [*The Bastard's Book of Ruby* - Parsing HTML with Nokogiri](http://ruby.bastardsbook.com/chapters/html-parsing/)

* [Video Review- Scraping and Object Orientation](https://www.youtube.com/watch?v=oXwdOdBUyCI) 

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/scraping-reading' title='Scraping HTML with Nokogiri'>Scraping HTML with Nokogiri</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/scraping-reading'>Scraping</a> on Learn.co and start learning to code for free.</p>
