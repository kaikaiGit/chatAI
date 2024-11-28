/* AI对话API的请求体类型 */
export interface XunFeiRequest {
  model: string,
  messages: Array<RequestMessage>,
  top_k: number,
  stream: boolean
}

export interface RequestMessage {
  role: string,
  content: string
}

/* AI对话API的响应体类型 */
export interface XunFeiResponse {
  code: number,
  message: string,
  sid: string,
  choice: Array<ResponseChoices>,
  usage: TokenUsage,
}

export interface ResponseChoices {
  message: ResponseMessage,
  index: number
}

export interface TokenUsage {
  prompt_tokens: number,
  completion_tokens: number,
  total_tokens: number
}

export interface ResponseMessage {
  role: string,
  content: string
}