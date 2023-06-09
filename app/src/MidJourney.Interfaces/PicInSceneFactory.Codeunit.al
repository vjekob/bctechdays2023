codeunit 50024 "PicInScene Factory"
{
    #region ImageDownloader
    var
        _ImageDownloader: Interface IImageDownloader;
        _ImageDownloaderIsDefined: Boolean;

    procedure ImageDownloader(): Interface IImageDownloader
    var
        DefaultImplementationCodeunit: Codeunit "Download Image";
    begin
        if not _ImageDownloaderIsDefined then
            SetImageDownloader(DefaultImplementationCodeunit);

        exit(_ImageDownloader);
    end;

    local procedure SetImageDownloader(IImageDownloader: Interface IImageDownloader)
    begin
        _ImageDownloader := IImageDownloader;
        _ImageDownloaderIsDefined := true;
    end;
    #endregion ImageDownloader

    #region ItemImageUrl
    var
        _ItemImageUrl: Interface IItemImageUrl;
        _ItemImageUrlIsDefined: Boolean;

    procedure ItemImageUrl(): Interface IItemImageUrl
    var
        DefaultImplementationCodeunit: Codeunit "ABS ItemImageUrl";
    begin
        if not _ItemImageUrlIsDefined then
            SetItemImageUrl(DefaultImplementationCodeunit);

        exit(_ItemImageUrl);
    end;

    local procedure SetItemImageUrl(IItemImageUrl: Interface IItemImageUrl)
    begin
        _ItemImageUrl := IItemImageUrl;
        _ItemImageUrlIsDefined := true;
    end;
    #endregion ItemImageUrl

    #region MidJourney
    var
        _MidJourney: Interface IMidJourney;
        _MidJourneyIsDefined: Boolean;

    procedure MidJourney(): Interface IMidJourney
    var
        DefaultImplementationCodeunit: Codeunit MidJourney;
    begin
        if not _MidJourneyIsDefined then
            SetMidJourney(DefaultImplementationCodeunit);

        exit(_MidJourney);
    end;

    local procedure SetMidJourney(IMidJourney: Interface IMidJourney)
    begin
        _MidJourney := IMidJourney;
        _MidJourneyIsDefined := true;
    end;
    #endregion MidJourney

    #region ItemWriter
    var
        _ItemWriter: Interface IItemWriter;
        _ItemWriterIsDefined: Boolean;

    procedure ItemWriter(): Interface IItemWriter
    var
        DefaultImplementationCodeunit: Codeunit "Item Pic-In-Scene Writer";
    begin
        if not _ItemWriterIsDefined then
            SetItemWriter(DefaultImplementationCodeunit);

        exit(_ItemWriter);
    end;

    local procedure SetItemWriter(IItemWriter: Interface IItemWriter)
    begin
        _ItemWriter := IItemWriter;
        _ItemWriterIsDefined := true;
    end;
    #endregion ItemWriter
}