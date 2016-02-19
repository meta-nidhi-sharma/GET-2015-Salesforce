@isTest(SeeAllData=false)
private class TestStack {
    static Stack stack = new Stack();
    @isTest
    static void testIsEmpty(){
        System.assertEquals(true, stack.isEmpty());
    }
    @isTest
    static void testSize(){
        System.assertEquals(0, stack.size());
    }
    @isTest
    static void testPush(){
        stack.push('Nidhi');
        stack.push('Neha');
        System.assertEquals(2, stack.size());
    }
    
    @isTest
    static void testPop(){
        stack.push('Richa');
        stack.push('Chetna');
        stack.pop();
        System.assertEquals(1, stack.size());
    }
    @isTest
    static void testPopEmptyStack(){
        Stack testStack = new Stack();
        System.assertEquals(null, testStack.pop());
    } 
    @isTest
    static void testPeek(){
        stack.push('Suman');
        stack.push('Anjita');
        System.assertEquals('Anjita', stack.peek());
    }
    @isTest
    static void testPeekNullStack(){
        Stack testStack = new Stack();
        System.assertEquals(null, testStack.peek());
    }
}