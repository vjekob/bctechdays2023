codeunit 50030 "HttpSend" implements IHttpSend
{
    var
        WebClient: HttpClient;
        WebRequest: HttpRequestMessage;
        WebResponse: HttpResponseMessage;
        WebRequestHeaders: HttpHeaders;
        WebContentHeaders: HttpHeaders;
        WebContent: HttpContent;
        CurrentContentType: Text;
        RestHeaders: TextBuilder;
        ContentTypeSet: Boolean;

    procedure Initialize(Method: Text; URI: Text);
    begin
        WebRequest.Method := Method;
        WebRequest.SetRequestUri(URI);

        WebRequest.GetHeaders(WebRequestHeaders);
    end;

    procedure AddRequestHeader(HeaderKey: Text; HeaderValue: Text)
    begin
        RestHeaders.AppendLine(HeaderKey + ': ' + HeaderValue);

        WebRequestHeaders.Add(HeaderKey, HeaderValue);
    end;

    procedure AddBody(Body: Text)
    begin
        WebContent.WriteFrom(Body);

        ContentTypeSet := true;
    end;

    procedure SetContentType(ContentType: Text)
    begin
        CurrentContentType := ContentType;

        webcontent.GetHeaders(WebContentHeaders);
        if WebContentHeaders.Contains('Content-Type') then
            WebContentHeaders.Remove('Content-Type');
        WebContentHeaders.Add('Content-Type', ContentType);
    end;

    procedure Send(IHttpLogger: Interface IHttpLogger) SendSuccess: Boolean
    var
        StartDateTime: DateTime;
        TotalDuration: Duration;
    begin
        if ContentTypeSet then
            WebRequest.Content(WebContent);

        StartDateTime := CurrentDateTime();
        SendSuccess := WebClient.Send(WebRequest, WebResponse);
        TotalDuration := CurrentDateTime() - StartDateTime;

        if SendSuccess then
            if not WebResponse.IsSuccessStatusCode() then
                SendSuccess := false;

        IHttpLogger.Log(WebContent, CurrentContentType, WebRequest, WebResponse, RestHeaders, StartDateTime, TotalDuration);

    end;

    procedure GetResponseContentAsText() ResponseContentText: Text
    var
        RestBlob: Codeunit "Temp Blob";
        Instr: Instream;
    begin

        RestBlob.CreateInStream(Instr);
        WebResponse.Content().ReadAs(ResponseContentText);
    end;

    procedure GetResponseReasonPhrase(): Text
    begin
        exit(WebResponse.ReasonPhrase());
    end;

    procedure GetHttpStatusCode(): Integer
    begin
        exit(WebResponse.HttpStatusCode());
    end;

}