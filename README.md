# TgUpBot - Telegram Up Bot

This project, written in Perl, enables the extraction of image and description metadata from PDF ebooks to back up your e-books in your Telegram public/private group/channel.

# Pre-Requisites

- Perl
- ImageMagick
- cURL
- Calibre tools (fetch-ebook-metadata)

## Instalation

To install this project following this steps:

``` 
git clone git@github.com:jhonesto/TgUpBot.git
```

## Using
To use this project just run the command as follow:

```
perl TgUpBot -t|--token "TOKEN" -f|--folder "FOLDER" -c|--chat-id "CHAT-ID"
``` 

