class SearchResultsList extends React.Component {

  render() {
    return (
      <ul className="dropdown-menu" id="autocomplete-items" onMouseEnter={() => {this.props.setPreventHideDropdown()}} onMouseLeave={() => {this.props.resetPreventHideDropdown()}}>
        <span className="dropdown-arrow-top"></span>
        <span className="dropdown-arrow-bottom"></span>
        <li>
          <a href={`/search?q=${this.props.term}`}>
            <i className="fa fa-search"></i> Search for <strong>{this.props.term}</strong>
          </a>
        </li>
        {this.renderStoryHeading()}
        {this.renderStories()}
        {this.renderUserHeading()}
        {this.renderUsers()}
        {this.renderTagHeading()}
        {this.renderTags()}
      </ul>
    );
  }

  renderStories() {
   return this.props.stories.slice(0, 3).map((story) => {
      return <SearchStoryListItem key={story.id} story={story} />
    });
  }

  renderUsers() {
    return this.props.users.slice(0, 3).map((user) => {
      return <SearchUserListItem key={user.id} user={user} />
    });
  }

  renderTags() {
    return this.props.tags.slice(0, 3).map((tag) => {
      return <SearchTagListItem key={tag.id} tag={tag} />
    });
  }

  renderStoryHeading() {
    if (this.props.stories.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>Stories</h4></li>
  }

  renderUserHeading() {
    if (this.props.users.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>People</h4></li>
  }

  renderTagHeading() {
    if (this.props.tags.length === 0) { return; }

    return <li className="autocomplete-heading"><h4>Tags</h4></li>
  }
}