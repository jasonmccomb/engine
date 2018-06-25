import React from 'react';
import { expect } from 'chai';
import { shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

import Startup from '../../../javascript/src/locomotive/content_editing/views/startup.jsx'; //should put in tests utils

describe('components', () => {
  describe('Startup', () => {
    it('should render a loading screen', () => {
      const wrapper = shallow(<Startup />);
      expect(wrapper.text()).to.contain('Waiting');
    });
  })
})