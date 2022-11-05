.class public final synthetic Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$OE4cG-d0jzV4gLmaKMvhpuUAJlI;
.super Ljava/lang/Object;
.source "lambda"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Ljava/util/Set;

.field public final synthetic f$1:Landroid/content/Context;


# direct methods
.method public synthetic constructor <init>(Ljava/util/Set;Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$OE4cG-d0jzV4gLmaKMvhpuUAJlI;->f$0:Ljava/util/Set;

    iput-object p2, p0, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$OE4cG-d0jzV4gLmaKMvhpuUAJlI;->f$1:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$OE4cG-d0jzV4gLmaKMvhpuUAJlI;->f$0:Ljava/util/Set;

    iget-object v1, p0, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$OE4cG-d0jzV4gLmaKMvhpuUAJlI;->f$1:Landroid/content/Context;

    invoke-static {v0, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->lambda$cancelAllPendingNotificationIntents$1(Ljava/util/Set;Landroid/content/Context;)V

    return-void
.end method
