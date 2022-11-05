.class public interface abstract Lcom/samsung/android/gamesdk/GameSDKManager$Listener;
.super Ljava/lang/Object;
.source "GameSDKManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/samsung/android/gamesdk/GameSDKManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x609
    name = "Listener"
.end annotation


# virtual methods
.method public abstract onHighTempWarning(I)V
.end method

.method public abstract onRefreshRateChanged()V
.end method

.method public abstract onReleasedByTimeout()V
.end method

.method public abstract onReleasedCpuBoost()V
.end method

.method public abstract onReleasedGpuBoost()V
.end method
