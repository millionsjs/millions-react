var React = require('react');

export default class Renderer extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    render() {
        return (
            <div>
                Hello world!
            </div>
        );
    }
}
