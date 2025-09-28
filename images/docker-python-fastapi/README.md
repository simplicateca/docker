# simplicateca/python-fastapi:3.13

Custom Python 3.13 image for FastAPI apps.
Includes a curated stack for APIs, NLP/AI, parsing, media, email, and data pipelines.

## OS & Core Packages

* Python 3.13 (Debian slim)
* ffmpeg, ImageMagick, Ghostscript
* nano (debug editor)
* build-essential (compiled away in final image if using multi-stage build)

## Python Libraries Included

See [requirements.txt](./requirements.txt) for the full list:
- FastAPI, Uvicorn, httpx, aiofiles
- OpenAI, LangChain, ChromaDB, Spacy, Unstructured
- Meilisearch, MinIO, Dropbox, MongoDB, PostgreSQL
- PyPDF2, pdfplumber, python-docx, openpyxl, Pandas, PyArrow
- Pillow, OpenCV, ffmpeg-python, MoviePy, Pydub, Vosk
- Scrapy, Trafilatura, Google API Client
- Markdown-it-py, feedparser
- aiosmtplib, Mailersend, imap-tools, mail-parser
- Twilio, Slackbot, Signalbot
- Rich, Loguru, Watchdog, Tavily
- Yake, PKE, Archive Reddit User, BDFR

## Usage

Build locally:

```bash
docker build -t simplicateca/python-fastapi:local ./images/docker-python-fastapi
docker run -it --rm -p 8000:8000 -v $(pwd):/app simplicateca/python-fastapi:local
