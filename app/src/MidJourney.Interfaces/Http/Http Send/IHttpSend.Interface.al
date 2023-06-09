interface "IHttpSend"
{
    procedure Initialize(Method: Text; URI: Text);
    procedure AddRequestHeader(HeaderKey: Text; HeaderValue: Text)
    procedure AddBody(Body: Text)
    procedure SetContentType(ContentType: Text)
    procedure Send(IHttpLogger: Interface IHttpLogger) SendSuccess: Boolean
    procedure GetResponseContentAsText() ResponseContentText: Text
    procedure GetResponseReasonPhrase(): Text
    procedure GetHttpStatusCode(): Integer

}