class SearchContainer extends React.Component {
  constructor(props) {
    super(props)

    this.state = { preventHideDropdown: false, showDropdown: false, term: '', stories: [], users: [], tags: [] }
    this.hideDropdown = this.hideDropdown.bind(this);
    this.showDropdown = this.showDropdown.bind(this);
    this.setPreventHideDropdown = this.setPreventHideDropdown.bind(this);
    this.resetPreventHideDropdown = this.resetPreventHideDropdown.bind(this);
  }

  search(term) {
    this.setState({ term });

    $.ajax({
      url: `/api/autocomplete.json/?term=${term}`,
      method: 'GET',
      success: (data) => { this.setState({
        stories: data.stories,
        users: data.users,
        tags: data.tags
      });}
    });
  }

  setPreventHideDropdown() {
    this.setState({ preventHideDropdown: true });
  }

  resetPreventHideDropdown() {
    this.setState({ preventHideDropdown: false });
  }

  hideDropdown() {
    if (!this.state.preventHideDropdown) {
      this.setState({ showDropdown: false });
    }
  }

  showDropdown() {
    this.setState({ showDropdown: true });
  }

  render () {
    return (
      <div>
        <SearchBar 
          showDropdown={this.showDropdown}
          hideDropdown={this.hideDropdown}
          term={this.state.term} 
          onSearchTermChange={(term) => {this.search(term)}}
        />
        {this.renderSearchResults()}
      </div>
    );
  }

  renderSearchResults() {
    if(!this.state.showDropdown || (this.state.stories.length === 0 && this.state.users.length === 0 && this.state.tags.length === 0)) {
      return;
    }

    return (
      <SearchResultsList
        setPreventHideDropdown={this.setPreventHideDropdown}
        resetPreventHideDropdown={this.resetPreventHideDropdown}
        term={this.state.term}
        stories={this.state.stories}
        users={this.state.users}
        tags={this.state.tags}
      />
    );
  }
}
