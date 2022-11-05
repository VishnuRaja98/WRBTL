.class public final synthetic Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$fSttc7CuZmP-kDH-q_FquZSJ7Yk;
.super Ljava/lang/Object;
.source "lambda"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Landroid/content/Context;

.field public final synthetic f$1:Ljava/util/Set;


# direct methods
.method public synthetic constructor <init>(Landroid/content/Context;Ljava/util/Set;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$fSttc7CuZmP-kDH-q_FquZSJ7Yk;->f$0:Landroid/content/Context;

    iput-object p2, p0, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$fSttc7CuZmP-kDH-q_FquZSJ7Yk;->f$1:Ljava/util/Set;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$fSttc7CuZmP-kDH-q_FquZSJ7Yk;->f$0:Landroid/content/Context;

    iget-object v1, p0, Lcom/unity/androidnotifications/-$$Lambda$UnityNotificationManager$fSttc7CuZmP-kDH-q_FquZSJ7Yk;->f$1:Ljava/util/Set;

    invoke-static {v0, v1}, Lcom/unity/androidnotifications/UnityNotificationManager;->lambda$triggerHousekeeping$0(Landroid/content/Context;Ljava/util/Set;)V

    return-void
.end method
