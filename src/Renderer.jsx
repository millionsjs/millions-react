var React = require('react');
var Millions = require('millions');

export default class Renderer extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
    }

    _initRenderer(rendererClass) {
        this.renderer = new rendererClass(this.refs.mountpoint);
        this.forceUpdate();
    }

    componentDidMount() {
        if (this.props.rendererClass) {
            this._initRenderer(this.props.rendererClass);
        } else {
            this._initRenderer(Millions.getBestSupportedRenderer());
        }
    }

    componentWillReceiveProps(newProps) {
        if (newProps.rendererClass != this.props.rendererClass) {
            this._initRenderer(newProps.rendererClass);
        }
    }

    shouldComponentUpdate(newProps, newState) {
        return newProps.scene != this.props.scene || newProps.camera != this.props.camera;
    }

    render() {
        if (this.renderer) {
            this.renderer.render(this.props.scene, this.props.camera);
        }

        return (
            <canvas ref="mountpoint"></canvas>
        );
    }
}
