# simplicateca/python-fastapi:3.10

Originally based on [tiangolo/uvicorn-gunicorn:python3.10](https://github.com/tiangolo/uvicorn-gunicorn-docker/blob/master/docker-images/python3.10.dockerfile).

In addition to building with FastAPI and Uvicorn, this image also contains includes a number of Python libraries useful for building web applications, APIs, and NLP tools.

## OS & Core Packages

* Python 3.10 (Debian 12)
* nano (text editor - for when you have to shell in to debug something)

## Python Libraries Included

* fastapi
* trafilatura
* Scrapy
* requests
* youtube-dl
* PyPDF2
* moviepy
* pydub
* vosk
* youtube_transcript_api
* google-api-python-client
* python-frontmatter
* tavily-python
* Jinja2
* dropbox
* meilisearch
* miniflux
* watchdog
* archive-reddit-user
* bdfr
* twilio
* slackbot
* signalbot
* langchain
* tiktoken
* unstructured
* chromadb
* pymongo
* psycopg2
* openai
* spacy
* git+https://github.com/LIAAD/yake
* git+https://github.com/boudinfl/pke.git


### Libraries being considered

* gpt4all
* langchain
* langgraph
* langchainhub
* langchain_community
* langchain-openai
* langchain-mistralai
* llama-cpp-python
