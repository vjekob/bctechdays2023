interface IHttpClient
{
    /// <summary>
    /// The reason why this interface wraps the response message, but not the request message, is because the
    /// request message can be fully controlled by AL code, while response message is only controlled by the
    /// actual HttpClient runtime.
    ///
    /// When test doubles implement this interface, they can both set up and access a request message, but they
    /// can not set up a fake response message. That's why a wrapper is provided for it.
    /// </summary>
    procedure Send(RequestMessage: HttpRequestMessage; var ResponseMessage: Interface IHttpResponseMessage): Boolean;
}
