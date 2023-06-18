interface IMidjourneyFactory
{
    procedure GetMidjourneySetup(): Interface IMidjourneySetup;
    procedure GetMidjourneyImagine(): Interface IMidjourneyImagine;
    procedure GetMidjourneyResult(): Interface IMidjourneyResult;
    procedure GetMidjourneySend(): Interface IMidjourneySend;
    procedure GetConfigurationProvider(): Interface IConfigurationProvider;
    procedure GetHttpClient(): Interface IHttpClient;
    procedure GetBlockedByEnvironmentHandler(): Interface IBlockedByEnvironmentHandler;
    procedure GetHttpErrorHandler(): Interface IHttpErrorHandler;
    procedure GetTransportErrorHandler(): Interface ITransportErrorHandler;
}
