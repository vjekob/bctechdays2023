interface "IHttpLogger"
{
    procedure Log(WebContent: HttpContent; ContentType: Text; WebRequest: HttpRequestMessage; WebResponse: HttpResponseMessage; RestHeaders: TextBuilder; StartDateTime: DateTime; TotalDuration: Duration);
}