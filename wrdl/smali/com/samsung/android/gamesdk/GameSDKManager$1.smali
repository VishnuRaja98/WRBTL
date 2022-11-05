.class Lcom/samsung/android/gamesdk/GameSDKManager$1;
.super Lcom/samsung/android/gamesdk/IGameSDKListener$Stub;
.source "GameSDKManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/samsung/android/gamesdk/GameSDKManager;->setListener(Lcom/samsung/android/gamesdk/GameSDKManager$Listener;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/samsung/android/gamesdk/GameSDKManager;


# direct methods
.method constructor <init>(Lcom/samsung/android/gamesdk/GameSDKManager;)V
    .locals 0

    .line 331
    iput-object p1, p0, Lcom/samsung/android/gamesdk/GameSDKManager$1;->this$0:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-direct {p0}, Lcom/samsung/android/gamesdk/IGameSDKListener$Stub;-><init>()V

    return-void
.end method


# virtual methods
.method public onHighTempWarning(I)V
    .locals 1

    .line 334
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager$1;->this$0:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-static {v0}, Lcom/samsung/android/gamesdk/GameSDKManager;->access$000(Lcom/samsung/android/gamesdk/GameSDKManager;)Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/samsung/android/gamesdk/GameSDKManager$Listener;->onHighTempWarning(I)V

    return-void
.end method

.method public onRefreshRateChanged()V
    .locals 1

    .line 338
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager$1;->this$0:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-static {v0}, Lcom/samsung/android/gamesdk/GameSDKManager;->access$000(Lcom/samsung/android/gamesdk/GameSDKManager;)Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

    move-result-object v0

    invoke-interface {v0}, Lcom/samsung/android/gamesdk/GameSDKManager$Listener;->onRefreshRateChanged()V

    return-void
.end method

.method public onReleasedByTimeout()V
    .locals 1

    .line 342
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager$1;->this$0:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-static {v0}, Lcom/samsung/android/gamesdk/GameSDKManager;->access$000(Lcom/samsung/android/gamesdk/GameSDKManager;)Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

    move-result-object v0

    invoke-interface {v0}, Lcom/samsung/android/gamesdk/GameSDKManager$Listener;->onReleasedByTimeout()V

    return-void
.end method

.method public onReleasedCpuBoost()V
    .locals 1

    .line 347
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager$1;->this$0:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-static {v0}, Lcom/samsung/android/gamesdk/GameSDKManager;->access$000(Lcom/samsung/android/gamesdk/GameSDKManager;)Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

    move-result-object v0

    invoke-interface {v0}, Lcom/samsung/android/gamesdk/GameSDKManager$Listener;->onReleasedCpuBoost()V

    return-void
.end method

.method public onReleasedGpuBoost()V
    .locals 1

    .line 351
    iget-object v0, p0, Lcom/samsung/android/gamesdk/GameSDKManager$1;->this$0:Lcom/samsung/android/gamesdk/GameSDKManager;

    invoke-static {v0}, Lcom/samsung/android/gamesdk/GameSDKManager;->access$000(Lcom/samsung/android/gamesdk/GameSDKManager;)Lcom/samsung/android/gamesdk/GameSDKManager$Listener;

    move-result-object v0

    invoke-interface {v0}, Lcom/samsung/android/gamesdk/GameSDKManager$Listener;->onReleasedGpuBoost()V

    return-void
.end method
