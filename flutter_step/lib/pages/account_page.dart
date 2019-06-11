import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
	@override
	_AccountPageState createState() => new _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
	StepperType stepperType = StepperType.horizontal;
	List<Step> steps = [
		Step(
			title: const Text('New Account'),
			isActive: true,
			state: StepState.complete,
			content: Column(
				children: <Widget>[
					TextFormField(
						decoration: InputDecoration(labelText: 'Email Address'),
					),
					TextFormField(
						decoration: InputDecoration(labelText: 'Password'),
					),
				],
			),
		),
		Step(
			isActive: false,
			state: StepState.editing,
			title: const Text('Address'),
			content: Column(
				children: <Widget>[
					TextFormField(
						decoration: InputDecoration(labelText: 'Home Address'),
					),
					TextFormField(
						decoration: InputDecoration(labelText: 'Postcode'),
					),
				],
			),
		),
		Step(
			state: StepState.error,
			title: const Text('Avatar'),
			subtitle: const Text("Error!"),
			content: Column(
				children: <Widget>[
					CircleAvatar(
						backgroundColor: Colors.red,
					)
				],
			),
		),
	];

	int currentStep = 0;
	bool complete = false;

	next() {
		currentStep + 1 < steps.length ? goTo(currentStep + 1) : setState(() => complete = true);
	}

	goTo(int step) {
		setState(() {
		  currentStep = step;
		});
	}

	cancel() {
		if (currentStep > 0) {
			goTo(currentStep - 1);
		}
	}

	switchStepType() {
		setState(() {
			stepperType = stepperType == StepperType.horizontal ? StepperType.vertical : StepperType.horizontal;
		});
	}

	@override
	Widget build(BuildContext context) {
		return new Scaffold(
			appBar: AppBar(
				title: Text('Create an account'),
			),
			body: Column(children: <Widget>[
				Expanded(
					child: Stepper(
						steps: steps,
						currentStep: currentStep,
						type: stepperType,
						onStepContinue: next,
						onStepTapped: (step) => goTo(step),
						onStepCancel: cancel
					),
				),
			]),
			floatingActionButton: FloatingActionButton(child: Icon(Icons.list), onPressed: switchStepType),
		);
	}
}