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