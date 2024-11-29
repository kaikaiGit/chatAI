/* AI对话API的请求体类型 */
export interface XunFeiRequest {
  model: string,
  messages: Array<Message>,
  top_k: number,
  stream: boolean
}

/* AI对话API的响应体类型 */
export interface XunFeiResponse {
  code: number,
  message: string,
  sid: string,
  choices: Array<ResponseChoices>,
  usage: TokenUsage,
}

interface ResponseChoices {
  message: Message,
  index: number
}

interface TokenUsage {
  prompt_tokens: number,
  completion_tokens: number,
  total_tokens: number
}

export interface Message {
  role: string,
  content: string
}