interface IMidjourneyFactory
{
    procedure GetMidjourneySetup(): Interface IMidjourneySetup;

    procedure GetMidjourneyImagine(): Interface IMidjourneyImagine;

    procedure GetMidjourneyResult(): Interface IMidjourneyResult;

    procedure GetMidjourneySend(): Interface IMidjourneySend;

    procedure GetConfigurationProvider(): Interface IConfigurationProvider;
}
