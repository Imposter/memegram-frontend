# Memegram Backend
### Introduction
Memes are a form self-expression, humor and a way to convey emotion. However, memes have become a part of mainstream culture virtually undistinguishable from normal social media. We decided to create a platform exclusively devoted to memes and nothing else. Memegram allows users to quickly, efficiently and anonymously upload their own memes onto the site, and anyone can access and view them. Comments are also utilized so that other users can also express themselves and their opinions on the meme. When a meme is uploaded, the user is prompted to enter topics. These topics are tags which are utilized for searching. Memegram is a platform that we created to create a community for everyone who enjoys the humors of memes. Everyone is welcome to the platform and is encouraged to express their creativity, humor and feelings through memes.

### Requirements
The following are requirements to compile and run the server:
- Node.js with Node Package Manager (npm) ([Details](https://nodejs.org/en/download/))
- Typescript v2.x+ ([Details](https://www.typescriptlang.org/index.html#download-links))
- Webpack 4.x+ ([Details](https://www.typescriptlang.org/index.html#download-links))
- MongoDB v3.6.x+ server and database ([Details](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-windows/))

### Setup
1. Run `npm install` to install Node.js packages
2. Modify `webpack.config.js` (development config) or `webpack.prod.config.js` (production config) to refer to your server
3. Run `webpack --config <config file>` to build for the specified configuration, output will be in `dist`

## Usage
- You can either host the application on your server, or run a local server using `http-server --port 8080 dist`

### Authors
- Eyaz Rehman
- Rameet Sekhon