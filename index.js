const puppeteer = require('puppeteer');
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var util = require('util');

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

const port = 31040;
const host = util.format('http://0.0.0.0:%s/', port);

/**
 * 延迟执行
 * @param ms 毫秒
 * @returns {Promise<unknown>}
 */
function wait(ms) {
    return new Promise(resolve => setTimeout(() => resolve(), ms));
}

/**
 * 获取ssr渲染后app元素的html数据
 * @param {string} url
 */
const getAppHtmlData = async (url) => {
    const browser = await puppeteer.launch({
        headless: true,
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
        ]
    });
    const page = await browser.newPage();

    const userAgent = 'Mozilla/5.0 (Linux; Android 5.1; OPPO R9tm Build/LMY47I; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/53.0.2785.49 Mobile MQQBrowser/6.2 TBS/043220 Safari/537.36 MicroMessenger/6.5.7.1041 NetType/4G Language/zh_CN'
    await page.setUserAgent(userAgent);
    await page.setViewport({width: 375, height: 812});

    // /* 优化请求 start */
    // // 1. 监听网络请求
    // await page.setRequestInterception(true);
    // page.on('request', req => {
    //     // 2. 忽略不必要的请求，如图片，视频样式等等
    //     const whitelist = ['document', 'script'];
    //     if (!whitelist.includes(req.resourceType())) {
    //         return req.abort();
    //     }
    //
    //     // 3. 其它请求正常继续
    //     req.continue();
    // });
    // /* 优化请求 end */

    // const url = util.format(apiCSRHtml, id);
    // const url = util.format(apiCSRHtml, id);
    if (!url) {
        url = 'https://focus.youth.cn/article/newshare_four?signature=nG63ezAQDowMB0vlYg4k0n9NJTqKOJy7L8KN5yR9XpjPOxrbdE&scene_id=home_feed&share_id=54053024390181951624114382318&time=1624114386257';
    }
    await page.goto(url);

    await wait(2000);

    let puppeteerResponse = await page.evaluate(() => {
        document.getElementById('open_all').click()

        return {
            appHtml: document.title,
            // appHtml: '',
        };
    });

    // await wait(5000);
    // await page.screenshot({
    //     path: 'screenshot.png',
    //     fullPage: true,
    // });

    await browser.close();

    return puppeteerResponse.appHtml;
};

//
app.get('/click', function (req, res) {
    (async () => {
        let jsonData = await getAppHtmlData(req.query.url);
        console.log('jsonData: ', jsonData)
        res.json({
            'html': jsonData,
        });
    })();
});

// 监听
app.listen(port);

console.log("host: %s", host);
