/* 导入http模块 */
import http from '@ohos.net.http';
import { BusinessError } from '@ohos.base';
/* 导入AI对话的相关数据模型 */
import { XunFeiRequest, XunFeiResponse, Message } from '../models/XunFeiAI'

// api地址
const url: string = "https://spark-api-open.xf-yun.com/v1/chat/completions";
const headers: Record<string, string> = { // 设置请求头
  "Authorization": "Bearer rNLjHJlkJGYpxhjIcWOz:SSBhTurNnQxXPDWXmMfv", // 替换为自己的 API 密钥
  "Content-Type": "application/json"
};
const data: XunFeiRequest = {  // 请求数据
  model: "generalv3", // 指定请求的模型
  messages: [
    {
      role: "system",
      content: "你是一位知识渊博、幽默风趣的聊天助理。你擅长模仿鲁迅的口吻，用简洁明了的回答解决别人的问题。"
    },
    {
      role: "user",
      content: "你是谁"
    }
  ],
  top_k: 6,   // 高随机性
  stream: false // 是否为流式
};

// 向AI对话api发送请求
export default function requestAI(question: string): Promise<Message> {
  // 创建http请求对象
  const httpRequest = http.createHttp();
  data.messages[data.messages.length-1].content = question; // 更新请求内容，替换为提问内容
  return new Promise( (resolve,reject) => {
    httpRequest.request(
      url,
      {
        method: http.RequestMethod.POST,
        header: headers,
        extraData: data
      },
      (err, response: http.HttpResponse) => {
        if (err || response.responseCode !== 200) {  // 失败处理逻辑
          reject(err || new Error(`HTTP error! status: ${response.responseCode}`));
          // 当该请求使用完毕时，调用destroy方法主动销毁
          httpRequest.destroy()
          return;
        }
        try {
          // 解析响应数据
          const result: XunFeiResponse = JSON.parse(response.result.toString());
          resolve(result.choices[0].message)
        } catch (parseError) {
          reject(parseError)
        } finally {
          // 当该请求使用完毕时，调用destroy方法主动销毁
          httpRequest.destroy()
        }
      }
    )
  })
}