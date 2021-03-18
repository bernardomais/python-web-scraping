import requests, json
from bs4 import BeautifulSoup

res = requests.get('https://aws.amazon.com/pt/blogs/aws/')
res.encoding = 'utf-8'
soup = BeautifulSoup(res.text, 'html.parser')
posts = soup.find_all(class_='blog-post')
all_posts = []

for post in posts:
    title = post.find(class_='blog-post-title').text
    preview = post.find(class_='blog-post-excerpt').text
    image = post.find(class_='wp-post-image')['src']
    meta = post.find(class_='blog-post-meta')
    time = meta.time['datetime']
    author = meta.find(property='author').text

    all_posts.append({
        'title': title,
        'author': author,
        'time': time,
        'image': image,
        'preview': preview
    })

with open('response/aws-posts.json', 'w') as json_file:
    json.dump(all_posts, json_file, indent=3, ensure_ascii=False)