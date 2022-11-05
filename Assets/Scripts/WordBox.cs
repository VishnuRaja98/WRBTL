using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public enum LetterState
{
    correct = 0,
    nearby=1,
    notthere=2,
    unknown=4
}
public class WordBox : MonoBehaviour
{
    readonly int animatorTriggerReset = Animator.StringToHash("Reset");
    readonly int animatorTriggerShake = Animator.StringToHash("Shake");
    readonly int animatorStateParameter = Animator.StringToHash("State");

    Animator animator = null;

    public LetterState LetterState { get; private set; } = LetterState.unknown;
    // Start is called before the first frame update
    void Start()
    {
        animator = GetComponent<Animator>();
        //Debug.Log("animatorState="+animator.GetInteger("State"));
    }
    public void setState(int state)
    {
        // -1 = wrong, 1 = nearby, 2 = correct;
        animator.SetInteger("State", state);
        //Debug.Log("animator state set to " + state);
    }
    public void Shake()
    {
        animator.SetTrigger(animatorTriggerShake);
    }
    public void ResetText()
    {
        LetterState = LetterState.unknown;
        animator.SetInteger(animatorStateParameter, -1);
        animator.SetTrigger(animatorTriggerReset);
    }

    public void SetState(LetterState letterState)
    {
        LetterState = letterState;
        animator.SetInteger(animatorStateParameter, (int)letterState);
    }
}
