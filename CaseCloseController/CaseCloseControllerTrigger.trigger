trigger CaseCloseControllerTrigger on Case (before update) {
    
    CaseCloseController.caseError(Trigger.New);

}
