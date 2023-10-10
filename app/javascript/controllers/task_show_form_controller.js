import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="task-show-form"
export default class extends Controller {
	submit() {
		this.element.requestSubmit();
	}
}
