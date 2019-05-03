
class CounterBloc {
  double counter=0;
  double increment;

  setCounter(double incr) {
    
    increment = incr;
  }

  increase() {
    counter+=increment;
  }

actualise(DateTime date){
 DateTime now = DateTime.now();

 int difference = now.difference(date).inSeconds;
 counter=increment*difference;

}

}
