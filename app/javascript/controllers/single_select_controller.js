import { Controller } from '@hotwired/stimulus';
import SlimSelect from 'slim-select';

// Connects to data-controller="single-select"
export default class extends Controller {
	connect() {
		this.select = new SlimSelect({
			select: this.element,
			settings: {
				showSearch: false,
				openPosition: 'auto',
			},
			events: {
				afterChange: (newVal) => {
					this.element.value = newVal[0].value;
					this.element.dispatchEvent(
						new Event('input', {
							bubbles: true,
							cancelable: true,
						})
					);
				},
			},
		});
	}
}
