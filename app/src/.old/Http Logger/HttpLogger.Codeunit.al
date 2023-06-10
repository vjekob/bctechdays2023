codeunit 50029 "HttpLogger" implements IHttpLogger
{
    procedure Log(WebContent: HttpContent; ContentType: Text; WebRequest: HttpRequestMessage; WebResponse: HttpResponseMessage; RestHeaders: TextBuilder; StartDateTime: DateTime; TotalDuration: Duration);
    var
        RESTLog: Record "Http Log";
        RestBlob: Codeunit "Temp Blob";
        ResponseBlob: Codeunit "Temp Blob";
        Instr: InStream;
        ResponseInstr: InStream;
        Outstr: OutStream;
    begin
        RestBlob.CreateInStream(Instr);
        WebContent.ReadAs(Instr);

        ResponseBlob.CreateInStream(ResponseInstr);
        WebResponse.Content().ReadAs(ResponseInstr);

        RESTLog.Init();
        RESTLog.RequestUrl := copystr(WebRequest.GetRequestUri(), 1, MaxStrLen(RESTLog.RequestUrl));
        RESTLog.RequestMethod := copystr(WebRequest.Method(), 1, MaxStrLen(RESTLog.RequestMethod));

        RESTLog.RequestBody.CreateOutStream(Outstr);
        CopyStream(Outstr, Instr);

        RESTLog.RequestBodySize := RESTLog.RequestBody.Length();
        RESTLog.ContentType := copystr(RESTLog.ContentType, 1, MaxStrLen(RESTLog.ContentType));
        RESTLog.RequestHeaders := copystr(RestHeaders.ToText(), 1, MaxStrLen(RESTLog.RequestHeaders));
        RESTLog.ResponseHttpStatusCode := WebResponse.HttpStatusCode();

        RESTLog.Response.CreateOutStream(Outstr);
        CopyStream(Outstr, ResponseInstr);
        RESTLog.ResponseSize := RESTLog.Response.Length();
        RESTLog.DateTimeCreated := StartDateTime;

        RESTLog.User := copystr(userid(), 1, MaxStrLen(RESTLog.User));

        RESTLog.Duraction := TotalDuration;
        RESTLog.Insert();
    end;
}