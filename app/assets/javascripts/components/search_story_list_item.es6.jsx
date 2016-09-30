class SearchStoryListItem extends React.Component {
  render() {
    return (
      <li>
        <a href={this.props.story.url}>
          <img width="35" className="avatar-image" src={this.props.story.avatar_url} />
          <span dangerouslySetInnerHTML={{ __html: this.props.story.title }} />
        </a>
      </li>
    );
  }
}